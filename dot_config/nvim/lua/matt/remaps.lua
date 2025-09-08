vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- GOOD STUFF -- 

-- Chef's kiss - When pasting over word x, do not place x into buffer
keymap('x', 'p', [["_dP]])

-- Set ; -> : for faster commands
keymap('n', ';', ':')

-- more good
keymap({ 'n', 'o', 'x' }, '<s-h>', '^', opts)
keymap({ 'n', 'o', 'x' }, '<s-l>', 'g_', opts)

-- Prime
keymap('v', 'J', ":m '>+1<CR>gv=gv", {desc = 'Move current line down'})
keymap('v', 'K', ":m '<-2<CR>gv=gv", {desc = 'Move current line up'})

keymap('n', 'J', 'mzJ`z', {desc = 'Remove space from next line'})

keymap({'n', 'v'}, '<leader>y', [["+y"]], {desc = 'Yank next word'})
keymap('n', '<leader>Y', [["+Y"]], {desc = 'Yank next line'})

keymap({'n', 'v'}, '<leader>d', [["_d"]], {desc = 'Delete && !No Buf'})

keymap("n", "<leader>%g", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  {desc = 'Replace all under cursor'})

-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- center after movement commands
keymap('n', 'n', 'nzzzv', opts)
keymap('n', 'N', 'Nzzzv', opts)
keymap('n', '*', '*zz', opts)
keymap('n', '#', '#zz', opts)
keymap('n', 'g*', 'g*zz', opts)
keymap('n', 'g#', 'g#zz', opts)
keymap('n', '<C-d>', '<C-d>zz')
keymap('n', '<C-u>', '<C-u>zz')

vim.api.nvim_set_keymap('t', '<C-;>', '<C-\\><C-n>', opts)

keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- keymap('n', '<C-i>', '<C-i>', opts)

-- Diagnostic keymaps
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
keymap('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.cmd [[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]]
vim.cmd [[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]]
-- vim.cmd [[:amenu 10.120 mousemenu.-sep- *]]

keymap('n', '<RightMouse>', '<cmd>:popup mousemenu<CR>')
keymap('n', '<Tab>', '<cmd>:popup mousemenu<CR>')

keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window Navigation
keymap('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

