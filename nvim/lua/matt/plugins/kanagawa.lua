return {
  'rebelot/kanagawa.nvim',
  config = function()
    require('kanagawa').setup {
      keywordStyle = { italic = false },
      overrides = function(colors)
        local palette = colors.palette
        return {
          String = { italic = true },

          Operator = { fg = palette.dragonGray2 },

          -- static
          Boolean = { fg = palette.dragonPink },
          Constant = { fg = palette.dragonPink },
          Number = { fg = palette.dragonPink },

          -- hard
          Keyword = { fg = palette.dragonRed }, -- strength of builtin keywords (core)

          -- functions
          Function = { fg = palette.dragonOrange }, -- action
          ['@function.builtin'] = { fg = palette.dragonOrange },
          ['@lsp.type.magicFunction'] = { fg = palette.dragonOrange },
          ['@lsp.typemod.function.builtin'] = { fg = palette.dragonOrange },
          ['@lsp.typemod.function.defaultLibrary'] = { fg = palette.dragonOrange },
          ['@lsp.typemod.method.defaultLibrary'] = { fg = palette.dragonOrange },
          ['@lsp.typemod.function.readonly'] = { fg = palette.dragonOrange },

          -- types
          Type = { fg = palette.dragonYellow }, -- creativity, data structure
          Special = { fg = palette.dragonYellow }, -- creativity, data structure

          -- parameters/members
          Identifier = { fg = palette.dragonBlue },
          Statement = { fg = palette.dragonBlue }, -- logic, focus
          -- ["@lsp.typemod.function.readonly"] = { fg = palette.dragonBlue },
          ['@variable.member'] = { fg = palette.dragonBlue },

          -- variables
          -- increase readability, fujiWhite blends too much
          ['@namespace'] = { fg = palette.dragonWhite },
          ['@variable.builtin'] = { fg = palette.dragonRed },
          ['@variable.parameter'] = { fg = palette.dragonWhite },
          ['@variable'] = { fg = palette.dragonWhite },
          ['@attribute'] = { fg = palette.dragonWhite },
        }
      end,
    }
    -- vim.cmd 'colorscheme kanagawa-dragon'
  end,
}
