return {
  'CopilotC-Nvim/CopilotChat.nvim',
  branch = 'main',
  dependencies = {
    { 'zbirenbaum/copilot.lua' }, -- required
    { 'nvim-lua/plenary.nvim' }, -- required
  },
  config = function()
    require('CopilotChat').setup {
      mappings = {
        reset = {
          normal = '',
          insert = '',
        },
      },
      model = 'claude-3.5-sonnet',
      show_help = true,
      prompts = {
        Explain = 'Explain how this code works.',
        Fix = 'Fix this code.',
        Review = 'Review this code.',
        Tests = 'Suggest tests for this code.',
        Refactor = 'Refactor this code to improve clarity.',
      },
    }
  end,
}
