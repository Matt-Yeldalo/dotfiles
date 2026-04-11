return {
  'zbirenbaum/copilot.lua',
  requires = { 'copilotlsp-nvim/copilot-lsp' },
  cmd = 'Copilot',
  event = 'InsertEnter',
  requires = {
    "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
  },
  config = function()
    require('copilot').setup {
      -- auth_provider_url = "https://busways.ghe.com",
      suggestion = {
        enabled = true,
        auto_trigger = true,
        model = 'haiku-4.5',
        keymap = {
          accept = '<S-Tab>', -- Shift+Tab to accept
        },
      },
      panel = { enabled = true },
      filetypes = {
        bash = false,
        sh = false,
        yaml = true,
        markdown = true,
        help = false,
        gitcommit = true,
        gitrebase = true,
      },
    }
  end,
}
