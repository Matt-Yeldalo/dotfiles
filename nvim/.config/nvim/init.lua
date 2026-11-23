require 'matt.remaps'
require 'matt.options'

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- 1. Set filetype for .js.erb
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.js.erb',
  callback = function()
    vim.bo.filetype = 'jserb'
  end,
})

-- 2. Register 'jserb' pointing to the embedded_template binary AND C symbol
local parser_paths = vim.api.nvim_get_runtime_file('parser/embedded_template.*', false)
if #parser_paths > 0 then
  vim.treesitter.language.add('jserb', {
    path = parser_paths[1],
    symbol_name = 'embedded_template',
  })
end

-- 3. Set highlights and injections for the 'jserb' language
vim.treesitter.query.set(
  'jserb',
  'highlights',
  [[
  [
    "<%"
    "<%="
    "<%=="
    "<%-"
    "<%#"
    "%>"
    "-%>"
    "=%>"
  ] @keyword

  (comment_directive) @comment
]]
)

vim.treesitter.query.set(
  'jserb',
  'injections',
  [[
  ((code) @injection.content
   (#set! injection.language "ruby")
   (#set! injection.combined))

  ((content) @injection.content
   (#set! injection.language "javascript")
   (#set! injection.combined))
]]
)

-- 4. Start Tree-sitter with the new 'jserb' language
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'jserb',
  callback = function(args)
    vim.treesitter.start(args.buf, 'jserb')
  end,
})
vim.treesitter.language.register('markdown', 'octo')

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'rust',
    'bash',
    'c',
    'diff',
    'html',
    'scss',
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
    'eruby',
    'jserb',
    'javascript',
    'copilot-chat',
    'gitcommit',
    'gitrebase',
    'gitconfig',
    -- 'gitignore',
  },
  callback = function()
    vim.treesitter.start()
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({ spec = { { import = 'matt.plugins' } } }, { ui = { icons = require 'matt.icons' } })
