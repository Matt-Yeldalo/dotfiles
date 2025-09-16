return {
  'zbirenbaum/copilot.lua',
  dependencies = { 'giuxtaposition/blink-cmp-copilot' },
  cmd = 'Copilot',
  config = function()
    local copilot = require 'copilot'

    copilot.setup {
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          -- jump_prev = '[[',
          -- jump_next = ']]',
          -- accept = '<CR>',
          -- refresh = 'gr',
          open = '<M-CR>',
        },
        layout = {
          position = 'bottom',
          ratio = 0.4,
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = false,
        debounce = 75,
        keymap = {
          accept = '<M-l>',
          accept_word = false,
          accept_line = false,
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-]>',
        },
      },
      filetypes = {
        yaml = true,
        markdown = true,
        help = true,
        gitcommit = true,
        gitrebase = true,
        hgcommit = true,
        svn = true,
        cvs = true,
        ['.'] = true,
      },
      server_opts_overrides = {},
    }
  end,
}
