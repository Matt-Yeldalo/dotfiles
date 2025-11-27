require 'matt.remaps'
require 'matt.options'

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
  -- { -- Adds git related signs to the gutter, as well as utilities for managing changes
  --   'lewis6991/gitsigns.nvim',
  --   opts = {
  --     signs = {
  --       add = { text = '+' },
  --       change = { text = '~' },
  --       delete = { text = '_' },
  --       topdelete = { text = '‾' },
  --       changedelete = { text = '~' },
  --     },
  --   },
  -- },
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          mappings = {
            i = { ['<c-enter>'] = 'to_fuzzy_refine' },
          },
        },
        pickers = {},
        extensions = {
          fzf = {},
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      local root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'Gemfile' }, { upward = true })[1])
      -- Rails custom maps
      vim.keymap.set('n', '<leader>sv', function()
        builtin.find_files {
          cwd = root_dir .. '/app/views',
        }
      end, { desc = '[S]each [V]iews' })

      vim.keymap.set('n', '<leader>sc', function()
        builtin.find_files {
          cwd = root_dir .. '/app/controllers',
        }
      end, { desc = '[S]each [C]ontrollers' })

      vim.keymap.set('n', '<leader>sm', function()
        builtin.find_files {
          cwd = root_dir .. '/app/models',
        }
      end, { desc = '[S]each [M]odels' })

      vim.keymap.set('n', '<leader>sj', function()
        builtin.find_files {
          cwd = root_dir .. '/app/javascript',
        }
      end, { desc = '[S]each [J]avascript' })

      vim.keymap.set('n', '<leader>ss', function()
        builtin.find_files {
          cwd = root_dir .. '/app/assets/stylesheets',
        }
      end, { desc = '[S]each [S]tylesheets' })

      vim.keymap.set('n', '<leader>sa', function()
        builtin.find_files {
          cwd = root_dir .. '/app/components',
        }
      end, { desc = '[S]each Components' })

      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      -- vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader><leader>', builtin.oldfiles, { desc = '[ ] Search Recent Files' })
      vim.keymap.set('n', '<leader>s.', builtin.buffers, { desc = '[S]earch Buffers ("." for repeat)' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = true,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
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
        local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
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
  },


  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}
      luasnip.filetype_extend('eruby', { 'html' })
      luasnip.filetype_extend('erb', { 'html' })
      luasnip.filetype_extend('eruby', { 'html' })

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          -- ['<Tab>'] = cmp.mapping.confirm { select = true },
          --['<Tab>'] = cmp.mapping.select_next_item(),
          --['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          -- ['<C-Space>'] = cmp.mapping.complete {},

          -- ['<C-l>'] = cmp.mapping(function()
          --   if luasnip.expand_or_locally_jumpable() then
          --     luasnip.expand_or_jump()
          --   end
          -- end, { 'i', 's' }),
          -- ['<C-h>'] = cmp.mapping(function()
          --   if luasnip.locally_jumpable(-1) then
          --     luasnip.jump(-1)
          --   end
          -- end, { 'i', 's' }),
        },
        sources = {
          { name = 'copilot', group_index = 2 },
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.icons').setup()
      require('mini.surround').setup()
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    opts = {
      playground = {
        enable = true,
      },
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'regex',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'ruby',
        'embedded_template',
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },
  { import = 'matt.plugins' },
}, {
  ui = {
    icons = require 'matt.icons',
  },
})
