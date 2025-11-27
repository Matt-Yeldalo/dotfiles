return {
  -- LSP setup via vim.lsp only (no lspconfig)
  'nvim-lua/plenary.nvim',
  dependencies = {
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, { bufnr = event.buf }) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, { bufnr = event.buf }) then
          map('<leader>th', function()
            local enabled = vim.lsp.inlay_hint.is_enabled(event.buf)
            vim.lsp.inlay_hint.enable(event.buf, not enabled)
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    if vim.g.have_nerd_font then
      local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
      local diagnostic_signs = {}
      for type, icon in pairs(signs) do
        diagnostic_signs[vim.diagnostic.severity[type]] = icon
      end
      vim.diagnostic.config { signs = { text = diagnostic_signs } }
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    local function root_pattern(...)
      local patterns = { ... }
      return function(startpath)
        local path = startpath or vim.api.nvim_buf_get_name(0)
        local found = vim.fs.find(patterns, { path = vim.fs.dirname(path), upward = true })[1]
        if found then
          return vim.fs.dirname(found)
        end
        return nil
      end
    end

    local servers = {
      ruby_lsp = {
        filetypes = { 'ruby', 'rb', 'eruby', 'erb' },
        cmd = { 'bundle', 'exec', 'ruby-lsp' },
        root_dir = root_pattern('Gemfile', '.ruby-lsp'),
      },
      rubocop = {
        filetypes = { 'rb', 'ruby' },
        cmd = { 'bundle', 'exec', 'rubocop', '--lsp' },
        root_dir = root_pattern('.rubocop.yml', 'Gemfile'),
      },
      cssls = {
        filetypes = { 'css', 'scss', 'sass', 'less' },
        cmd = { 'vscode-css-language-server', '--stdio' },
        root_dir = root_pattern('package.json', '.git'),
      },
      ts_ls = {
        filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx', 'javascript', 'javascriptreact', 'javascript.jsx' },
        cmd = { 'typescript-language-server', '--stdio' },
        root_dir = root_pattern('tsconfig.json', 'jsconfig.json', 'package.json'),
        single_file_support = false,
      },
      lua_ls = {
        filetypes = { 'lua' },
        cmd = { 'lua-language-server' },
        capabilities = {},
        settings = {
          Lua = {
            completion = { callSnippet = 'Replace' },
          },
        },
        root_dir = function(startpath)
          local buf = startpath or vim.api.nvim_buf_get_name(0)
          local cfg = vim.fn.stdpath 'config'
          if buf:find(cfg, 1, true) == 1 then
            return cfg
          end
          local found = vim.fs.find({ '.luarc.json', '.luarc.jsonc', 'lua' }, { path = vim.fs.dirname(buf), upward = true })[1]
          if found then
            return vim.fs.dirname(found)
          end
          return nil
        end,
      },
    }

    local get_default = (vim.lsp and type(vim.lsp.config) == 'function') and vim.lsp.config or function()
      return {}
    end

    local notified_missing = {}
    local function cmd_exists(cmd)
      if type(cmd) == 'table' then
        if #cmd == 0 then
          return true
        end
        local exe = cmd[1]
        if exe:sub(1, 1) == '/' then
          return vim.fn.filereadable(exe) == 1
        end
        return vim.fn.executable(exe) == 1
      elseif type(cmd) == 'string' then
        if cmd:sub(1, 1) == '/' then
          return vim.fn.filereadable(cmd) == 1
        end
        return vim.fn.executable(cmd) == 1
      end
      return true
    end

    local function try_start(cfg, bufnr)
      if cfg.cmd and not cmd_exists(cfg.cmd) then
        local key = (cfg.name or 'lsp') .. '|' .. (type(cfg.cmd) == 'table' and (cfg.cmd[1] or '') or cfg.cmd)
        if not notified_missing[key] then
          vim.notify(
            ("LSP '%s' not started: command '%s' not found. Check your PATH or install it."):format(
              cfg.name or '?',
              type(cfg.cmd) == 'table' and (cfg.cmd[1] or '') or tostring(cfg.cmd)
            ),
            vim.log.levels.WARN
          )
          notified_missing[key] = true
        end
        return
      end

      local ok, res = pcall(vim.lsp.start, cfg)
      if not ok or not res then
        local err = ok and 'unknown error (nil client id)' or tostring(res)
        vim.notify(("LSP '%s' failed to start: %s"):format(cfg.name or '?', err), vim.log.levels.ERROR)
        return
      end

      if bufnr and type(res) == 'number' then
        pcall(vim.lsp.buf_attach_client, bufnr, res)
      end
    end

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('matt-lsp-autostart', { clear = true }),
      callback = function(args)
        local bufnr = args.buf
        local ft = vim.bo[bufnr].filetype
        for name, server in pairs(servers) do
          local base = get_default(name) or {}
          local fts = server.filetypes or base.filetypes
          if not fts or vim.tbl_contains(fts, ft) then
            local cfg = vim.tbl_deep_extend('force', {}, base, server)
            cfg.capabilities = vim.tbl_deep_extend('force', {}, capabilities, cfg.capabilities or {})
            cfg.name = name
            if type(cfg.root_dir) == 'function' then
              cfg.root_dir = cfg.root_dir(vim.api.nvim_buf_get_name(bufnr))
            end
            cfg.bufnr = bufnr
            try_start(cfg, bufnr)
          end
        end
      end,
    })
  end,
}
