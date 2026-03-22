-- local theme = require 'matt.config.catppuccin'
-- local theme = require 'matt.config.onedarkpro'
-- return { theme }
return {
  'olimorris/onedarkpro.nvim',
  priority = 1000, -- Ensure it loads first
  config = function()
    vim.cmd 'colorscheme onedark_dark'
  end,
}
