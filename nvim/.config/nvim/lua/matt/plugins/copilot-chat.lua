return {
  'CopilotC-Nvim/CopilotChat.nvim',
  branch = 'main',
  dependencies = {
    { 'zbirenbaum/copilot.lua' },
    { 'nvim-lua/plenary.nvim' },
  },
  keys = {
    { '<leader>cp', '<cmd>CopilotChatOpen<CR>', desc = 'CopilotChat Open' },
  },
  config = function()
    require('CopilotChat').setup {
      mappings = {
        reset = {
          normal = '',
          insert = '',
          callback = function() end,
        },
      },
      model = 'claude-opus-4.5',
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

