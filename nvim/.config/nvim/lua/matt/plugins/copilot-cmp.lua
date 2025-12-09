return {
  'zbirenbaum/copilot-cmp',
  config = function()
    require('copilot_cmp').setup {
      -- mappings = {
      --   reset = {
      --     normal = '',
      --     insert = '',
      --     callback = function()
      --       require('copilot').reset()
      --     end,
      --   },
      -- },
    }
    -- vim.g.copilot_no_tab_map = true
    -- vim.g.copilot_hide_during_completion = false
    -- vim.g.copilot_proxy_strict_ssl = false
    -- vim.keymap.set('n', '<leader>cp', '<cmd>CopilotChatOpen<CR>', {})
  end,
}
