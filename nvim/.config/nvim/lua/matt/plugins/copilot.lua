return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  config = function()
    require('copilot').setup {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = '<S-Tab>', -- Shift+Tab to accept
        },
      },
      panel = { enabled = true },
    }
  end,
}
