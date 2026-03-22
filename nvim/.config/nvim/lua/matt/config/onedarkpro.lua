-- return {
--   'olimorris/onedarkpro.nvim',
--   priority = 1000,
--   config = function()
--     require('onedarkpro').setup {
--       styles = { -- You can set any of the style values to "NONE" to disable it
--         comments = 'italic', -- Value is any valid attr-list value `:help attr-list`
--         keywords = 'bold,italic',
--         functions = 'bold',
--       },
--       colors = { -- Override default colors
--         purple = '#ee77ee',
--       },
--       highlights = { -- Override highlight groups
--         CursorLineNr = { fg = '${orange}', bold = true },
--         -- CursorLineNr = { fg = '#d19a66', bold = true },
--         StatusLine = { fg = '#ede0c3', bg = '#2b2b2b' },
--         StatusLineNC = { fg = '${gray}', bg = '#2b2b2b' },
--         -- StatusLineNC = { fg = '#5c6370', bg = '#2b2b2b' },
--       },
--       options = {
--         cursorline = true,
--         lualine_transparency = true,
--         bold_keywords = true, -- Bold keywords
--         dim_inactive_windows = false, -- Non focused windows set to alternative background
--         transparent_background = false, -- Use background color for `Normal` and `NormalFloat` (NeoVim 0.9 only)
--       },
--     }
--     vim.cmd 'colorscheme onedark_dark'
--   end,
-- }
return {
  "olimorris/onedarkpro.nvim",
  priority = 1000, -- Ensure it loads first
}
