return {
  'olimorris/onedarkpro.nvim',
  priority = 1000,
  config = function()
    require('onedarkpro').setup {
      options = {
        cursorline = false, -- Use cursorline highlighting?
        transparency = true, -- Use a transparent background?
        terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
        lualine_transparency = true, -- Center bar transparency?
        highlight_inactive_windows = true, -- When the window is out of focus, change the normal background?
      },
      styles = {
        comments = 'italic',
        keywords = 'bold,italic',
        functions = 'bold',
      },
    }
    vim.cmd 'colorscheme vaporwave'
  end,
}
