vim.diagnostic.config({ virtual_text = false })
vim.g.have_nerd_font = true
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '120'

-- Tab/indent settings
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.breakindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.inccommand = 'split'

-- UI
vim.opt.cmdheight = 0
vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.scroll = 10
vim.opt.mouse = 'a'
vim.opt.list = true
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Performance/timing
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300

-- Files
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.clipboard = 'unnamedplus'

-- Disable auto-commenting on new lines
vim.opt.formatoptions:remove({ 'r', 'o' })

-- Better completion experience
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- Shorter messages, avoid hit-enter prompts
vim.opt.shortmess:append('sI')

-- Keep cursor position when yanking in visual mode (add to remaps if preferred)
vim.opt.jumpoptions = 'view'

-- Persistent cursor position across sessions
vim.opt.viewoptions = { 'cursor', 'folds' }

-- Reduce CursorHold event lag (useful for LSP hover, etc.)
vim.opt.redrawtime = 1500

-- Allow hidden buffers (switch without saving)
vim.opt.hidden = true

-- Better diff mode
vim.opt.diffopt:append({ 'algorithm:patience', 'indent-heuristic' })
