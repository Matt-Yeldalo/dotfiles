local scheme = 'onedark_dark'
local trans = false
return {
  'olimorris/onedarkpro.nvim',
  priority = 1000,
  config = function()
    vim.cmd('colorscheme ' .. scheme)
  end,
}
