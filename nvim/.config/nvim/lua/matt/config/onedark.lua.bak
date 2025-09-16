local scheme = 'onedark'
local trans = false
return {
  'navarasu/onedark.nvim',
  priority = 1000,
  config = function()
    require('onedark').setup {
      style = 'deep',
      transparent = trans,
      term_colors = true,
      ending_tildes = false,
      cmp_itemkind_reverse = false,

      toggle_style_key = '<leader>ot',
      toggle_style_list = { 'dark', 'darker', 'cool', 'warm', 'warmer', 'deep', 'light' },

      -- Options are italic, bold, underline, none and combos 'italic,bold'
      code_style = {
        comments = 'italic',
        keywords = 'italic',
        functions = 'bold',
        strings = 'none',
        variables = 'none',
      },

      lualine = { transparent = trans },
      diagnostics = { darker = true, undercurl = true, background = true },
    }

    vim.cmd('colorscheme ' .. scheme)
  end,
}
