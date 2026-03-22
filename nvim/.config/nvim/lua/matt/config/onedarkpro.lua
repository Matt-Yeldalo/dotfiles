return {
  'olimorris/onedarkpro.nvim',
  priority = 1000,
  config = function()
    require('onedarkpro').setup {
      styles = { -- You can set any of the style values to "NONE" to disable it
        comments = 'italic', -- Value is any valid attr-list value `:help attr-list`
        keywords = 'bold,italic',
        functions = 'bold',
        strings = 'NONE',
        variables = 'NONE',
      },
      colors = { -- Override default colors
        purple = '#ee77ee',
      },
      highlights = { -- Override highlight groups
        CursorLineNr = { fg = '${orange}', bold = true },
        StatusLine = { fg = '#ede0c3', bg = '#2b2b2b' },
        StatusLineNC = { fg = '${gray}', bg = '#2b2b2b' },
      },
      plugins = { -- Override which plugins highlight groups are loaded
        copilot = true,
        flash_nvim = true,
        neo_tree = true,
        nvim_cmp = true,
        render_markdown = true,
        telescope = true,
        nvim_notify = true,
        gitsigns = true,
        indentline = true,
        dashboard = true,
      },
      options = {
        bold_keywords = true, -- Bold keywords
        dim_inactive_windows = true, -- Non focused windows set to alternative background
        transparent_background = false, -- Use background color for `Normal` and `NormalFloat` (NeoVim 0.9 only)
      },
    }
    vim.cmd 'colorscheme onedark_dark'
  end,
}
