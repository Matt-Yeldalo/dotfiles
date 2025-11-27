return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      local palette = require('catppuccin.palettes').get_palette 'macchiato'

      require('catppuccin').setup {
        custom_highlights = {
          -- Snacks
          SnacksNotifierInfo = { fg = palette.lavender },
          SnacksNotifierIconInfo = { fg = palette.lavender },
          SnacksNotifierTitleInfo = { fg = palette.lavender, style = { 'italic' } },
          SnacksNotifierFooterInfo = { link = 'DiagnosticInfo' },
          SnacksNotifierBorderInfo = { fg = palette.lavender },
          SnacksPickerPreviewTitle = { fg = palette.crust, bg = palette.lavender },
          SnacksDashboardHeader = { fg = palette.lavender },

          ['@property'] = { fg = palette.lavender, style = require('catppuccin').options.styles.properties or {} },
        },
        styles = {
          comments = { 'italic' },
          conditionals = { 'italic' },
          functions = { 'bold' },
          keywords = { 'italic' },
        },
        dim_inactive = {
          enabled = true,
          shade = 'dark',
          percentage = 0.15,
        },
        background = {
          light = 'latte',
          dark = 'macchiato',
        },
        transparent_background = false,
        term_colors = true,
        integrations = {
          snacks = {
            enabled = true,
            indent_scope_color = 'lavender',
          },
          blink_cmp = true,
          gitsigns = true,
          treesitter = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { 'undercurl' },
              hints = { 'undercurl' },
              warnings = { 'undercurl' },
              information = { 'undercurl' },
            },
          },
          telescope = { enabled = true },
          which_key = true,
          mini = { enabled = true },
        },
      }
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    'rasulomaroff/reactive.nvim',
    optional = true,
    opts = {
      load = { 'catppuccin-macchiato-cursor', 'catppuccin-macchiato-cursorline' },
    },
  },
  {
    'rachartier/tiny-devicons-auto-colors.nvim',
    optional = true,
    opts = {
      factors = {
        lightness = 0.9,
        chroma = 1,
        hue = 0.7,
      },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      local palette = require('catppuccin.palettes').get_palette 'macchiato'
      local transparent_bg = require('catppuccin').options.transparent_background and 'NONE' or palette.mantle

      require('lualine').setup {
        options = {
          theme = {
            normal = {
              a = { bg = palette.lavender, fg = palette.mantle, gui = 'bold' },
              b = { bg = palette.surface0, fg = palette.lavender },
              c = { bg = transparent_bg, fg = palette.text },
            },
            insert = {
              a = { bg = palette.green, fg = palette.base, gui = 'bold' },
              b = { bg = palette.surface0, fg = palette.green },
            },
            terminal = {
              a = { bg = palette.green, fg = palette.base, gui = 'bold' },
              b = { bg = palette.surface0, fg = palette.green },
            },
            command = {
              a = { bg = palette.peach, fg = palette.base, gui = 'bold' },
              b = { bg = palette.surface0, fg = palette.peach },
            },
            visual = {
              a = { bg = palette.mauve, fg = palette.base, gui = 'bold' },
              b = { bg = palette.surface0, fg = palette.mauve },
            },
            replace = {
              a = { bg = palette.red, fg = palette.base, gui = 'bold' },
              b = { bg = palette.surface0, fg = palette.red },
            },
            inactive = {
              a = { bg = transparent_bg, fg = palette.lavender },
              b = { bg = transparent_bg, fg = palette.surface1, gui = 'bold' },
              c = { bg = transparent_bg, fg = palette.overlay0 },
            },
          },
        },
      }
    end,
  },
}
