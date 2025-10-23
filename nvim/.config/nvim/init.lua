-- Ultra-minimal, plugin-free Neovim config
-- Goal: favor native features; manual LSP start; simple grep/quickfix; basic Rails helpers; simple formatting fallbacks.

----------------------------
-- 0) Leader and essentials --
-----------------------------
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keep personal remaps and options in their own files for clarity
pcall(require, 'matt.remaps')
pcall(require, 'matt.options')

local opt = vim.opt
opt.number = true
opt.mouse = 'a'
opt.clipboard = 'unnamedplus'
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 250
opt.signcolumn = 'yes'
opt.termguicolors = true
opt.splitright = true
opt.splitbelow = true
opt.timeoutlen = 400
opt.path:append('**') -- enable :find recursive
opt.completeopt = { 'menu', 'menuone', 'noinsert' }

-- Use ripgrep for native grep if available
if vim.fn.executable('rg') == 1 then
  opt.grepprg = 'rg --vimgrep --hidden --glob !.git'
  opt.grepformat = '%f:%l:%c:%m'
end

----------------------------------
-- Plugins (native pack manager) --
----------------------------------
-- Install plugins into stdpath('data')/site/pack/min/start using git if missing
-- Rationale: keep plugin clones out of the dotfiles repo and in the data dir.
local site = vim.fn.stdpath('data') .. '/site'
vim.opt.packpath:prepend(site)

local registered_plugins = {}

local function ensure(start_dir, name, repo, opts)
  local install_path = start_dir .. '/' .. name
  if not (vim.uv or vim.loop).fs_stat(install_path) then
    vim.fn.mkdir(start_dir, 'p')
    local args = { 'git', 'clone', '--depth=1' }
    if opts and opts.branch then
      table.insert(args, '--branch=' .. opts.branch)
    end
    table.insert(args, 'https://github.com/' .. repo .. '.git')
    table.insert(args, install_path)
    local out = vim.fn.system(args)
    if vim.v.shell_error ~= 0 then
      vim.notify('Failed to install ' .. name .. ': ' .. out, vim.log.levels.ERROR)
    end
  end
  table.insert(registered_plugins, { name = name, path = install_path })
end

local start_dir = site .. '/pack/min/start'
ensure(start_dir, 'plenary.nvim', 'nvim-lua/plenary.nvim')
ensure(start_dir, 'oil.nvim', 'stevearc/oil.nvim')
ensure(start_dir, 'harpoon', 'ThePrimeagen/harpoon', { branch = 'harpoon2' })
ensure(start_dir, 'quick-note', 'matt-yeldalo/quick-note')
ensure(start_dir, 'which-key.nvim', 'folke/which-key.nvim')
ensure(start_dir, 'catppuccin', 'catppuccin/nvim')
ensure(start_dir, 'nvim-web-devicons', 'nvim-tree/nvim-web-devicons')
ensure(start_dir, 'fzf-lua', 'ibhagwan/fzf-lua')
ensure(start_dir, 'nvim-treesitter', 'nvim-treesitter/nvim-treesitter')
ensure(start_dir, 'nui.nvim', 'MunifTanjim/nui.nvim')
ensure(start_dir, 'noice.nvim', 'folke/noice.nvim')
ensure(start_dir, 'LuaSnip', 'L3MON4D3/LuaSnip')
ensure(start_dir, 'friendly-snippets', 'rafamadriz/friendly-snippets')
ensure(start_dir, 'gitsigns.nvim', 'lewis6991/gitsigns.nvim')
ensure(start_dir, 'copilot.vim', 'github/copilot.vim')
-- Completion engine (blink) + pairs
ensure(start_dir, 'blink.cmp', 'saghen/blink.cmp')
ensure(start_dir, 'nvim-autopairs', 'windwp/nvim-autopairs')

-- Helper: migrate any existing packs from config/site to data/site
pcall(function()
  local config_site = vim.fn.stdpath('config') .. '/site'
  local data_site = vim.fn.stdpath('data') .. '/site'
  local src = config_site .. '/pack/min/start'
  local dst = data_site .. '/pack/min/start'
  vim.fn.mkdir(dst, 'p')

  vim.api.nvim_create_user_command('PackMigrateToData', function()
    local entries = vim.fn.glob(src .. '/*', true, true)
    if not entries or #entries == 0 then
      vim.notify('No packs found under ' .. src, vim.log.levels.INFO)
      return
    end
    local moved, skipped = 0, 0
    for _, s in ipairs(entries) do
      if vim.fn.isdirectory(s) == 1 then
        local name = s:match('([^/]+)$')
        local target = dst .. '/' .. name
        if (vim.uv or vim.loop).fs_stat(target) then
          skipped = skipped + 1
        else
          local ok = (vim.uv or vim.loop).fs_rename(s, target)
          if ok then moved = moved + 1 else skipped = skipped + 1 end
        end
      end
    end
    vim.notify(string.format('Pack migrate: moved %d, skipped %d', moved, skipped), vim.log.levels.INFO)
  end, { desc = 'Move packs from config/site to data/site' })
end)

-- Simple pack management helpers to pin or check versions without leaving Neovim
pcall(function()
  local function sys(cmd, cwd)
    local res = vim.system(cmd, { text = true, cwd = cwd }):wait()
    return res.code, (res.stdout or ''):gsub('\n$', ''), (res.stderr or '')
  end

  local function for_each_plugin(fn)
    for _, p in ipairs(registered_plugins) do
      fn(p)
    end
  end

  vim.api.nvim_create_user_command('PackStatus', function()
    local lines = { 'PackStatus ~' }
    for_each_plugin(function(p)
      local code_h, head = sys({ 'git', 'rev-parse', '--short', 'HEAD' }, p.path)
      local _, tag = sys({ 'git', 'describe', '--tags', '--exact-match' }, p.path)
      local status
      if tag and #tag > 0 then
        status = string.format('%-22s tag:%s (%s)', p.name, tag, head or '?')
      else
        status = string.format('%-22s head:%s', p.name, head or '?')
      end
      table.insert(lines, status)
    end)
    vim.api.nvim_echo({ { table.concat(lines, '\n') } }, false, {})
  end, { desc = 'Show git status of all ensured plugins' })

  vim.api.nvim_create_user_command('PackCheckoutTags', function()
    for_each_plugin(function(p)
      sys({ 'git', 'fetch', '--tags', '--force' }, p.path)
      local code_t, latest = sys({ 'git', 'describe', '--tags', '--abbrev=0' }, p.path)
      if code_t == 0 and latest and #latest > 0 then
        local code_c = sys({ 'git', '-c', 'advice.detachedHead=false', 'checkout', '--force', latest }, p.path)
        if code_c ~= 0 then
          vim.notify('Failed to checkout tag for ' .. p.name .. ' (' .. (latest or '?') .. ')', vim.log.levels.WARN)
        end
      else
        -- no tags available; skip
      end
    end)
    vim.notify('Pack: checked out latest tags (where available).', vim.log.levels.INFO)
  end, { desc = 'Checkout latest tag for all ensured plugins' })

  vim.api.nvim_create_user_command('PackCheckout', function(opts)
    local name, ref = opts.fargs[1], opts.fargs[2]
    if not name or not ref then
      vim.notify('Usage: :PackCheckout {name} {ref}', vim.log.levels.WARN)
      return
    end
    for _, p in ipairs(registered_plugins) do
      if p.name == name then
        sys({ 'git', 'fetch', '--tags', '--force' }, p.path)
        local code = sys({ 'git', '-c', 'advice.detachedHead=false', 'checkout', '--force', ref }, p.path)
        if code == 0 then
          vim.notify('Checked out ' .. name .. ' -> ' .. ref, vim.log.levels.INFO)
        else
          vim.notify('Failed to checkout ' .. name .. ' -> ' .. ref, vim.log.levels.ERROR)
        end
        return
      end
    end
    vim.notify('Plugin not found: ' .. name, vim.log.levels.WARN)
  end, { nargs = 2, complete = function()
    local names = {}
    for _, p in ipairs(registered_plugins) do table.insert(names, p.name) end
    return names
  end, desc = 'Checkout a specific ref (tag/branch/commit) for a plugin' })
end)

-- Configure Oil (minimal)
pcall(function()
  require('oil').setup({
    columns = { 'icon' },
    view_options = { show_hidden = true },
    float = { border = 'rounded' },
    keymaps = {
        ['<C-h>'] = false,
        ['<C-l>'] = false,
        ['<M-h>'] = 'actions.select_split',
      },
      view_options = {
        show_hidden = true,
      },
  })
end)

-- Gitsigns: gutter changes with icons and handy mappings
pcall(function()
  -- Use thin lines for signs to keep gutter minimal
  local signs = {
    add = { text = '▎' },
    change = { text = '▎' },
    delete = { text = '▁' },
    topdelete = { text = '‾' },
    changedelete = { text = '▎' },
    untracked = { text = '┆' },
  }
  require('gitsigns').setup({
    signs = signs,
    current_line_blame = false,
    preview_config = { border = 'rounded' },
  })
  local gs = package.loaded.gitsigns
  -- Hunk navigation
  vim.keymap.set('n', ']h', gs.next_hunk, { desc = 'Git: next hunk' })
  vim.keymap.set('n', '[h', gs.prev_hunk, { desc = 'Git: prev hunk' })
  -- Hunk actions (fits your <leader>h group)
  vim.keymap.set('n', '<leader>hs', gs.stage_hunk, { desc = 'Hunk stage' })
  vim.keymap.set('n', '<leader>hr', gs.reset_hunk, { desc = 'Hunk reset' })
  vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Hunk undo stage' })
  vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { desc = 'Hunk preview' })
  vim.keymap.set('n', '<leader>hS', gs.stage_buffer, { desc = 'Buffer stage' })
  vim.keymap.set('n', '<leader>hb', gs.blame_line, { desc = 'Blame line' })
end)

-- Configure Harpoon v2 + keymaps
pcall(function()
  local harpoon = require('harpoon')
  harpoon:setup()
  vim.keymap.set('n', '<leader>ha', function() harpoon:list():add() end, { desc = 'Harpoon Add' })
  vim.keymap.set('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon Menu' })
  for i = 1, 6 do
    vim.keymap.set('n', '<leader>' .. i, function() harpoon:list():select(i) end, { desc = 'Harpoon ' .. i })
  end
end)

-- Configure Quick-Note and mapping
pcall(function()
  require('quick-note').setup({})
end)

-- Configure which-key (rounded border)
pcall(function()
  local wk = require('which-key')
  wk.setup({
    win = { border = 'rounded' },
    icons = { mappings = true },
    show_help = true,
  })
  -- New spec style groups
  wk.add({
    { "<leader>c", group = "[C]ode" },
    { "<leader>d", group = "[D]ocument" },
    { "<leader>r", group = "[R]ename" },
    { "<leader>s", group = "[S]earch" },
    { "<leader>t", group = "[T]oggle" },
    { "<leader>w", group = "[W]orkspace" },
    { "<leader>g", group = "[G]rep (native)" },
  })
  wk.add({
    { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
  })
end)

-- Colorscheme (catppuccin macchiato + integrations)
pcall(function()
  local cat = require('catppuccin')
  cat.setup({
    flavour = 'macchiato',
    integrations = {
      treesitter = true,
      gitsigns = true,
      which_key = true,
      noice = true,
      native_lsp = { enabled = true, inlay_hints = { background = true } },
      -- Improves CLI fzf colors (fzf-lua uses the fzf binary and will inherit these)
      fzf = true,
      ["blink-cmp"] = true,
    },
  })
  vim.cmd('colorscheme catppuccin')
end)

-- Devicons (enable icons for fzf-lua and oil)
pcall(function()
  require('nvim-web-devicons').setup({})
end)

-- GitHub Copilot (minimal): accept with Shift-Tab
pcall(function()
  vim.g.copilot_no_tab_map = true
  vim.g.copilot_assume_mapped = true
  vim.cmd([[imap <silent><script><expr> <S-Tab> copilot#Accept("\<CR>")]])
end)

-- LuaSnip + friendly-snippets (snippets for js, ruby, html, css/sass, erb)
pcall(function()
  local ls = require('luasnip')
  ls.config.set_config({
    history = true,
    updateevents = 'TextChanged,TextChangedI',
    enable_autosnippets = false,
    dependencies = { 'rafamadriz/friendly-snippets' },
  })
  -- Load VSCode-format community snippets lazily
  require('luasnip.loaders.from_vscode').lazy_load()

  -- Extend filetypes so ERB gets HTML and Ruby snippets
  ls.filetype_extend('eruby', { 'html', 'ruby' })
  -- If some setups report 'erb' instead of 'eruby', extend that too
  ls.filetype_extend('erb', { 'html', 'ruby' })

  -- Minimal keymaps for expand and jump (no completion plugin required)
  vim.keymap.set({ 'i', 's' }, '<C-k>', function()
    if ls.expandable() then ls.expand() end
  end, { desc = 'Snippet expand' })
  vim.keymap.set({ 'i', 's' }, '<C-l>', function()
    if ls.jumpable(1) then ls.jump(1) end
  end, { desc = 'Snippet jump forward' })
  vim.keymap.set({ 'i', 's' }, '<C-h>', function()
    if ls.jumpable(-1) then ls.jump(-1) end
  end, { desc = 'Snippet jump back' })
  vim.keymap.set({ 'i', 's' }, '<C-e>', function()
    if ls.choice_active() then ls.change_choice(1) end
  end, { desc = 'Snippet next choice' })
end)

-- fzf-lua (file picker, ripgrep integration)
pcall(function()
  local fzf = require('fzf-lua')
  fzf.setup({
    winopts = { border = 'rounded' },
    fzf_opts = { ['--layout'] = 'reverse' },
    files = { prompt = 'Files❯ ' },
    grep = { prompt = 'Grep❯ ', ripgrep = vim.fn.executable('rg') == 1 },
    -- Use Neovim highlights to color fzf for better theme coherence
    fzf_colors = true,
  })
  vim.keymap.set('n', '<leader>sf', fzf.files, { desc = '[F]ind [F]iles (fzf)' })
  vim.keymap.set('n', '<leader>sg', fzf.live_grep, { desc = '[F]ind by [G]rep (fzf)' })
  vim.keymap.set('n', '<leader>sb', fzf.buffers, { desc = '[F]ind [B]uffers (fzf)' })
  vim.keymap.set('n', '<leader>sh', fzf.help_tags, { desc = '[F]ind [H]elp (fzf)' })
  vim.keymap.set('n', '<leader><leader>', fzf.oldfiles, { desc = 'Recent files (fzf)' })
  -- LSP pickers
  vim.keymap.set('n', '<leader>sd', fzf.diagnostics_document, { desc = '[S]earch [D]iagnostics (buffer)' })
  vim.keymap.set('n', '<leader>sD', fzf.diagnostics_workspace, { desc = '[S]earch [D]iagnostics (workspace)' })
  vim.keymap.set('n', '<leader>ss', fzf.lsp_document_symbols, { desc = '[S]earch [S]ymbols (buffer)' })
  vim.keymap.set('n', '<leader>sw', fzf.lsp_live_workspace_symbols, { desc = '[S]earch [W]orkspace symbols' })
end)

-- Treesitter
pcall(function()
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'bash', 'lua', 'vim', 'vimdoc', 'query',
      'ruby', 'elixir', 'heex', 'embedded_template',
      'zig', 'javascript', 'typescript',
      'html', 'css', 'json', 'yaml', 'markdown', 'markdown_inline',
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
    playground = { enable = false },
    auto_install = true,
  })
end)

-- Helper command: update the 'vim' Treesitter parser to fix runtime query mismatch
-- Use when seeing: Invalid node type "substitute" in vim/highlights.scm
pcall(function()
  vim.api.nvim_create_user_command('TSFixVimParser', function()
    local ok, install = pcall(require, 'nvim-treesitter.install')
    if not ok then
      vim.notify('nvim-treesitter not available', vim.log.levels.ERROR)
      return
    end
    install.update({ with_sync = true })('vim')
    vim.notify('Treesitter: updated vim parser', vim.log.levels.INFO)
  end, { desc = 'Update Treesitter vim parser' })
end)

-- Noice: centered cmdline only (minimal)
pcall(function()
  require('noice').setup({
    presets = { lsp_doc_border = true },
    lsp = {
      progress = { enabled = false },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        -- harmless if cmp not present; improves doc rendering when used
        ["cmp.entry.get_documentation"] = true,
      },
    },
    messages = { enabled = false },
    notify = { enabled = false },
    popupmenu = { enabled = false },
    cmdline = {
      enabled = true,
      view = 'cmdline_popup',
      format = {},
    },
    views = {
      cmdline_popup = {
        position = { row = '50%', col = '50%' },
        size = { width = 60, height = 'auto' },
        border = { style = 'rounded' },
        win_options = { winblend = 0 },
      },
    },
  })
end)

-- nvim-autopairs (minimal)
pcall(function()
  require('nvim-autopairs').setup({
    check_ts = true,
    fast_wrap = {},
  })
end)

-- Completion: blink.cmp (fast LSP completion with docs/signature and auto-brackets)
pcall(function()
  local blink = require('blink.cmp')
  blink.setup({
    -- Keep defaults; Catppuccin integration styles the UI
    -- Enable auto brackets on accept for function items
    completion = {
      accept = {
        auto_brackets = { enabled = true },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
    },
    signature = { enabled = true },
  })
end)

---------------------------
-- 1) Useful autocmds     --
---------------------------
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('minimal-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

----------------------------------
-- 2) Root detection helper      --
----------------------------------
local function get_root(markers)
  markers = markers or { '.git' }
  local buf = vim.api.nvim_buf_get_name(0)
  local start = (buf ~= '' and vim.fs.dirname(buf)) or vim.uv.cwd()
  local found = vim.fs.find(markers, { upward = true, path = start })[1]
  return found and vim.fs.dirname(found) or start
end

-- Rails-root convenience
local function rails_root()
  return get_root({ 'Gemfile', '.git' })
end

----------------------------------
-- 3) Quickfix + search helpers --
----------------------------------
-- Grep word under cursor in project
vim.keymap.set('n', '<leader>gw', function()
  local word = vim.fn.expand('<cword>')
  local root = rails_root()
  vim.cmd('silent grep! ' .. vim.fn.shellescape(word) .. ' ' .. vim.fn.fnameescape(root))
  vim.cmd('copen')
end, { desc = '[G]rep current [W]ord (quickfix)' })

-- Live grep: prompt for pattern
vim.keymap.set('n', '<leader>g/', function()
  local pattern = vim.fn.input('Grep pattern: ')
  if pattern == '' then return end
  local root = rails_root()
  vim.cmd('silent grep! ' .. vim.fn.shellescape(pattern) .. ' ' .. vim.fn.fnameescape(root))
  vim.cmd('copen')
end, { desc = '[G]rep [/] pattern (quickfix)' })

-- Quickfix navigation
vim.keymap.set('n', '<leader>co', ':copen<CR>', { desc = '[C]quickfix [O]pen' })
vim.keymap.set('n', '<leader>cc', ':cclose<CR>', { desc = '[C]quickfix [C]lose' })
vim.keymap.set('n', '[q', ':cprevious<CR>', { desc = 'Quickfix prev' })
vim.keymap.set('n', ']q', ':cnext<CR>', { desc = 'Quickfix next' })

-- Rails dir helper pickers (fzf)
local function fzf_subdir_files(sub)
  local root = rails_root()
  local dir = root .. '/' .. sub
  if vim.fn.isdirectory(dir) == 0 then
    vim.notify('Directory not found: ' .. dir, vim.log.levels.WARN)
    return
  end
  local ok, fzf = pcall(require, 'fzf-lua')
  if not ok then
    vim.notify('fzf-lua not available', vim.log.levels.WARN)
    return
  end
  fzf.files({ cwd = dir, prompt = sub .. '❯ ' })
end

vim.keymap.set('n', '<leader>sv', function() fzf_subdir_files('app/views') end,
  { desc = '[S]earch [V]iews (fzf)' })
vim.keymap.set('n', '<leader>sc', function() fzf_subdir_files('app/controllers') end,
  { desc = '[S]earch [C]ontrollers (fzf)' })
vim.keymap.set('n', '<leader>sm', function() fzf_subdir_files('app/models') end,
  { desc = '[S]earch [M]odels (fzf)' })
vim.keymap.set('n', '<leader>sj', function() fzf_subdir_files('app/javascript') end,
  { desc = '[S]earch [J]avascript (fzf)' })
vim.keymap.set('n', '<leader>ss', function() fzf_subdir_files('app/assets/stylesheets') end,
  { desc = '[S]earch [S]tylesheets (fzf)' })
vim.keymap.set('n', '<leader>sa', function() fzf_subdir_files('app/components') end,
  { desc = '[S]earch Components (fzf)' })

-- Simple dynamic statusline (native)
vim.o.laststatus = 3
local function SL_branch()
  local head = vim.b.gitsigns_head
  return head and ('  ' .. head) or ''
end
local function SL_diag()
  local ok_icons, ic = pcall(require, 'matt.icons')
  local e = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local w = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  if ok_icons then
    local se = e > 0 and (ic.diagnostics.Error .. e .. ' ') or ''
    local sw = w > 0 and (ic.diagnostics.Warning .. w .. ' ') or ''
    return (se .. sw)
  else
    local se = e > 0 and ('E:' .. e .. ' ') or ''
    local sw = w > 0 and ('W:' .. w .. ' ') or ''
    return (se .. sw)
  end
end
function _G.Statusline()
  return table.concat({
    ' %f',
    ' %m',
    ' %r',
    '%= ',
    SL_diag(),
    SL_branch(),
    ' %l:%c',
    ' %p%%',
  })
end

vim.o.statusline = '%!v:lua.Statusline()'

----------------------------------
-- 4) Diagnostics signs (ASCII) --
----------------------------------
local ok_icons, icons = pcall(require, 'matt.icons')
vim.diagnostic.config({
  signs = {
    text = ok_icons and {
      [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
      [vim.diagnostic.severity.WARN]  = icons.diagnostics.Warning,
      [vim.diagnostic.severity.INFO]  = icons.diagnostics.Information,
      [vim.diagnostic.severity.HINT]  = icons.diagnostics.Hint,
    } or {
      [vim.diagnostic.severity.ERROR] = 'E',
      [vim.diagnostic.severity.WARN]  = 'W',
      [vim.diagnostic.severity.INFO]  = 'I',
      [vim.diagnostic.severity.HINT]  = 'H',
    }
  },
  float = { border = 'rounded' },
})

-- Rounded borders for LSP hover and signature help
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

----------------------------------
-- 5) LSP minimal bootstrap     --
----------------------------------
-- Shared on_attach: keymaps + omnifunc
local function on_attach(_, bufnr)
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = 'LSP: ' .. desc })
  end
  -- Essential LSP maps
  map('n', 'gd', vim.lsp.buf.definition, 'Goto Definition')
  map('n', 'gr', vim.lsp.buf.references, 'Goto References')
  map('n', 'gI', vim.lsp.buf.implementation, 'Goto Implementation')
  map('n', 'gD', vim.lsp.buf.declaration, 'Goto Declaration')
  map('n', 'K', vim.lsp.buf.hover, 'Hover')
  map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename')
  map({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, 'Code Action')
  map('n', '[d', vim.diagnostic.goto_prev, 'Prev Diagnostic')
  map('n', ']d', vim.diagnostic.goto_next, 'Next Diagnostic')
  map('n', '<leader>e', vim.diagnostic.open_float, 'Line Diagnostics')

  -- Omnifunc for completion
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

  -- Inlay hints toggle (if supported)
  local ok = pcall(function()
    if vim.lsp.inlay_hint then
      vim.keymap.set('n', '<leader>th', function()
        local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
        vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
      end, { buffer = bufnr, desc = 'Toggle Inlay Hints' })
    end
  end)
  if not ok then end
end

-- Advertise enhanced completion capabilities (for nvim-cmp)
local lsp_capabilities = (function()
  local caps = vim.lsp.protocol.make_client_capabilities()
  local ok, cmp_caps = pcall(require, 'cmp_nvim_lsp')
  if ok and cmp_caps and cmp_caps.default_capabilities then
    return cmp_caps.default_capabilities(caps)
  end
  return caps
end)()

-- Helper: start LSP if executable exists and not already attached
local function start_lsp_if_available(opts)
  if vim.fn.executable(opts.cmd[1]) ~= 1 then return end
  local root = opts.root_dir and opts.root_dir() or get_root({ '.git' })
  local existing = vim.lsp.get_clients({ name = opts.name, bufnr = 0 })
  if existing and #existing > 0 then return end
  vim.lsp.start({
    name = opts.name,
    cmd = opts.cmd,
    root_dir = root,
    on_attach = on_attach,
    capabilities = lsp_capabilities,
    settings = opts.settings,
  })
end

-- Ruby (Rubocop LSP)
local function start_rubocop_lsp()
  local root = rails_root()
  local has_gemfile = (vim.fn.filereadable(root .. '/Gemfile') == 1)
  local cmd
  if has_gemfile and vim.fn.executable('bundle') == 1 then
    cmd = { 'bundle', 'exec', 'rubocop', '--lsp' }
  else
    if vim.fn.executable('rubocop') ~= 1 then return end
    cmd = { 'rubocop', '--lsp' }
  end
  local existing = vim.lsp.get_clients({ name = 'rubocop', bufnr = 0 })
  if existing and #existing > 0 then return end
  vim.lsp.start({
    name = 'rubocop',
    cmd = cmd,
    root_dir = root,
    on_attach = on_attach,
    capabilities = lsp_capabilities,
  })
end
-- Herb (ERB files)
-- local function start_herb_ls()
--   start_lsp_if_available({
--     name = 'herb',
--     cmd = { 'herb-language-server', '--stdio' },
--     root_dir = rails_root(),
--   })
-- end

-- Elixir LS
local function start_elixirls()
  start_lsp_if_available({
    name = 'elixirls',
    cmd = { 'elixir-ls' },
    root_dir = function() return get_root({ 'mix.exs', '.git' }) end,
  })
end

-- Zig LSP
local function start_zls()
  start_lsp_if_available({
    name = 'zls',
    cmd = { '/home/matt/.zls/zls' },
    root_dir = function() return get_root({ 'build.zig', 'zls.json', '.git' }) end,
    settings = {
      zls = {
        enable_inlay_hints = true,
        enable_snippets = true,
        warn_style = true,
      },
    },
  })
end

-- TypeScript/JavaScript
local function start_tsserver()
  start_lsp_if_available({
    name = 'tsserver',
    cmd = { 'typescript-language-server', '--stdio' },
    root_dir = function() return get_root({ 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' }) end,
  })
end

-- CSS/SCSS/LESS LS
local function start_cssls()
  -- Try known command names
  local cmd
  if vim.fn.executable('vscode-css-language-server') == 1 then
    cmd = { 'vscode-css-language-server', '--stdio' }
  elseif vim.fn.executable('css-languageserver') == 1 then
    cmd = { 'css-languageserver', '--stdio' }
  else
    return
  end
  start_lsp_if_available({
    name = 'cssls',
    cmd = cmd,
    root_dir = function() return get_root({ 'package.json', '.git' }) end,
    settings = {},
  })
end

-- Lua LS (optional; handy if you edit Lua)
local function start_lua_ls()
  start_lsp_if_available({
    name = 'lua_ls',
    cmd = { 'lua-language-server' },
    root_dir = function() return get_root({ '.luarc.json', '.stylua.toml', '.git' }) end,
    settings = {
      Lua = {
        completion = { callSnippet = 'Replace' },
        diagnostics = { globals = { 'vim' } },
      },
    },
  })
end

-- Start servers on relevant filetypes
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('minimal-lsp-autostart', { clear = true }),
  callback = function(ev)
    local ft = ev.match
    if ft == 'ruby' then start_rubocop_lsp() end
    -- if ft == 'eruby' or ft == 'erb' then start_herb_lsp() end
    if ft == 'elixir' or ft == 'eelixir' or ft == 'heex' or ft == 'surface' then start_elixirls() end
    if ft == 'zig' then start_zls() end
    if ft == 'javascript' or ft == 'javascriptreact' or ft == 'typescript' or ft == 'typescriptreact' then start_tsserver() end
    if ft == 'css' or ft == 'scss' or ft == 'sass' or ft == 'less' then start_cssls() end
    if ft == 'lua' then start_lua_ls() end
  end,
})

----------------------------------
-- 6) Minimal formatting        --
----------------------------------
local function buf_get_text()
  return table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, true), '\n')
end

local function buf_replace_text(text)
  local lines = {}
  for s in (text .. '\n'):gmatch('([^\n]*)\n') do table.insert(lines, s) end
  -- Remove trailing empty extra line if present
  if #lines > 0 and lines[#lines] == '' then table.remove(lines, #lines) end
  vim.api.nvim_buf_set_lines(0, 0, -1, true, lines)
end

local function lsp_can_format()
  for _, c in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    if c.supports_method and c:supports_method('textDocument/formatting') then
      return true
    end
  end
  return false
end

local function run_system(cmd_list, input)
  -- Prefer vim.system when available (Neovim 0.10+)
  if vim.system then
    local res = vim.system(cmd_list, { text = true, stdin = input }):wait()
    return res.stdout, res.code
  else
    local out = vim.fn.system(cmd_list, input)
    return out, vim.v.shell_error
  end
end

local function format_ruby()
  local filename = vim.api.nvim_buf_get_name(0)
  local root = rails_root()
  local has_gemfile = (vim.fn.filereadable(root .. '/Gemfile') == 1)
  local base = { '--server', '--autocorrect-all', '--stderr', '--force-exclusion', '--stdin', filename }
  local cmd
  if has_gemfile and vim.fn.executable('bundle') == 1 then
    cmd = { 'bundle', 'exec', 'rubocop' }
  else
    cmd = { 'rubocop' }
  end
  for _, a in ipairs(base) do table.insert(cmd, a) end
  local out, code = run_system(cmd, buf_get_text())
  if code == 0 and out and out ~= '' then
    buf_replace_text(out)
  else
    vim.notify('Rubocop formatting failed', vim.log.levels.WARN)
  end
end

local function format_erb()
  if vim.fn.executable('erb-format') ~= 1 then
    vim.notify('erb-format not found in PATH', vim.log.levels.WARN)
    return
  end
  local cmd = { 'erb-format', '--stdin', '--print-width', '125' }
  local out, code = run_system(cmd, buf_get_text())
  if code == 0 and out and out ~= '' then
    buf_replace_text(out)
  else
    vim.notify('erb-format failed', vim.log.levels.WARN)
  end
end

-- CSS/SCSS/SASS/LESS fallback: Prettier via stdin (uses file extension to pick parser)
local function format_css_like_with_prettier()
  if vim.fn.executable('prettier') ~= 1 then
    vim.notify('Prettier not found in PATH', vim.log.levels.WARN)
    return
  end
  local filename = vim.api.nvim_buf_get_name(0)
  local cmd = { 'prettier', '--stdin-filepath', filename }
  local out, code = run_system(cmd, buf_get_text())
  if code == 0 and out and out ~= '' then
    buf_replace_text(out)
  else
    vim.notify('Prettier formatting failed', vim.log.levels.WARN)
  end
end

function _G.FormatBuffer()
  if lsp_can_format() then
    vim.lsp.buf.format({ async = true })
    return
  end
  local ft = vim.bo.filetype
  if ft == 'ruby' then return format_ruby() end
  if ft == 'eruby' then return format_erb() end
  if ft == 'css' or ft == 'scss' or ft == 'sass' or ft == 'less' then
    return format_css_like_with_prettier()
  end
  vim.notify('No formatter configured for ' .. ft, vim.log.levels.INFO)
end

vim.keymap.set({ 'n', 'x' }, '<leader>f', function() _G.FormatBuffer() end, { desc = '[F]ormat buffer' })

----------------------------------
-- 7) Small quality-of-life     --
----------------------------------
-- Use Oil as directory browser
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent dir (Oil)' })
vim.keymap.set('n', '<space>-', '<CMD>Oil --float<CR>', { desc = 'Open Oil (float)' })
-- Quick-Note shortcut
vim.keymap.set('n', '<leader>qn', ':QuickNote<CR>', { desc = 'Open Quick Note' })

-- Basic motions/mappings you might expect
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>', { desc = 'Clear search highlight' })

-- Syntax highlighting (built-in)
vim.cmd('syntax on')
