return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        model = 'opus-4.6',
        keymap = {
          accept = '<S-Tab>', -- Shift+Tab to accept
        },
      },
      panel = { enabled = true },
      filetypes = {
        bash = false,
        yaml = true,
        markdown = true,
        help = false,
        gitcommit = true,
        gitrebase = true
      },
    }
  end,
}
