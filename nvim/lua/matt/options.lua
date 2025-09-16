-- Disable f#ing ANNOYING auto comment
vim.cmd([[autocmd FileType * set formatoptions-=ro]])
-- vim.opt_local.formatoptions:remove({'r', 'o' })
vim.diagnostic.config({virtual_text = false})
vim.g.have_nerd_font = true
vim.o.cmdheight = 0
vim.o.cursorline = false
vim.o.wrap = false
vim.o.laststatus = 3

vim.opt.number = true
vim.opt.nu = true
vim.opt.termguicolors = true
vim.opt.relativenumber = true
-- Tab size
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'
-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false
-- Enable break indent
vim.opt.breakindent = true
-- Save undo history
vim.opt.undofile = true
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
-- Decrease update time
vim.opt.updatetime = 250
-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300
-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = {tab = '  ', trail = '·', nbsp = '␣' }
-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'
-- Show which line your cursor is on
vim.opt.cursorline = true
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.opt.colorcolumn = "120"
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.clipboard = 'unnamedplus'

