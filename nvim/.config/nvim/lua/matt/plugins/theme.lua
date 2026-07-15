return {
  'olimorris/onedarkpro.nvim',
  priority = 1000,
  config = function()
    require('onedarkpro').setup {
      themes = {
        -- Register our custom cozy warm theme
        cozy_dark = vim.fn.stdpath('config') .. '/lua/matt/themes/cozy_dark.lua',
      },
      options = {
        cursorline = true, -- Use cursorline highlighting?
        transparency = false, -- Use a transparent background?
        terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
        lualine_transparency = false, -- Center bar transparency?
        highlight_inactive_windows = false, -- When the window is out of focus, change the normal background?
      },
      styles = {
        comments = 'italic',
        keywords = 'bold,italic',
        functions = 'bold',
      },
    }
    vim.cmd 'colorscheme cozy_dark'
  end,
}
