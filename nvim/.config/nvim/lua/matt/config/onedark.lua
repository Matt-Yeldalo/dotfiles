local scheme = 'onedark'
local trans = false

return {
  'navarasu/onedark.nvim',
  priority = 1000,
  config = function()
    require('onedark').setup {
      style = 'darker',
      transparent = trans,
      term_colors = true,
      ending_tildes = false,
      cmp_itemkind_reverse = false,

      toggle_style_key = '<leader>ot',
      toggle_style_list = { 'dark', 'darker', 'cool', 'warm', 'warmer', 'deep', 'light' },

      code_style = {
        comments = 'italic',
        keywords = 'italic,bold',
        functions = 'bold',
        strings = 'none',
        variables = 'none',
      },

      colors = {
        red = '#ff6b64',
        pink = '#eb7d8a',
        purple = '#e68a8a',
        orange = '#ff8f52',
        yellow = '#f5aa57',
        green = '#b4af71',
        cyan = '#5ab0b0',
        blue = '#5d8cc9',
        fg = '#ede0c3',
        bg0 = '#111112',
        bg1 = '#1a1a1a',
        bg2 = '#2b2b2b',
        bg3 = '#383838',
        grey = '#847569',
      },

      lualine = { transparent = trans },
      diagnostics = { darker = true, undercurl = true, background = true },

      colors = {
        green = '#a3d38b',
        purple = '#c291f4',
        cyan = '#63d3e3',
        blue = '#61afef',
        yellow = '#ffd97a',
        red = '#ff6c75',
        orange = '#d19a66',
      },

      highlights = {
        -- Core keywords & flow control
        ['@keyword'] = { fg = '$purple', style = 'bold' },
        ['@keyword.return'] = { fg = '$purple', style = 'bold,underline' },

        -- Functions and methods
        ['@function'] = { fg = '$blue', style = 'bold' },
        ['@function.call'] = { fg = '$blue', style = 'bold' },

        -- Strings & Symbols (differentiate!)
        ['@string'] = { fg = '$yellow' }, -- "someClass"
        ['@string.special'] = { fg = '$orange' }, -- e.g., escaped chars
        ['@symbol'] = { fg = '$purple', style = 'bold' }, -- :full_name

        -- Constants, numbers, and booleans
        ['@constant'] = { fg = '$cyan', style = 'bold' },
        ['@number'] = { fg = '$cyan' },
        ['@boolean'] = { fg = '$cyan', style = 'bold' },

        -- HTML / XML / JSX
        ['@tag'] = { fg = '$blue', style = 'bold' },
        ['@tag.attribute'] = { fg = '$green' }, -- class=, id=, etc
        ['@tag.delimiter'] = { fg = '$fg' }, -- <, >

        -- Variables & fields
        ['@variable'] = { fg = '$fg' },
        ['@field'] = { fg = '$cyan' },
        ['@property'] = { fg = '$cyan' },
      },
    }

    vim.cmd('colorscheme ' .. scheme)
  end,
}
