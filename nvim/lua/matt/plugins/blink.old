local icons = require 'matt.icons'
return {
  'saghen/blink.cmp',
  version = '*',
  -- dependencies = 'rafamadriz/friendly-snippets',
  dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },
  opts = {
    snippets = { preset = 'luasnip' },
    keymap = { preset = 'default' },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono'
    },
    signature = { enabled = true },
    completion = {
      keyword = { range = 'prefix' },
      list = { selection = { preselect = true, auto_insert = false } },
      menu = {
        auto_show = true,
      },
      documentation = { auto_show = true, auto_show_delay_ms = 300 },
      ghost_text = { enabled = true }
    },
  }
}
