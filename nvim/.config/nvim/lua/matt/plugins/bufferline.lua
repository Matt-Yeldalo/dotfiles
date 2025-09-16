return {
  'akinsho/bufferline.nvim',
  after = 'catppuccin',
  config = function()
    vim.keymap.set('n', '<leader>tn', '<Cmd>BufferLineCycleNext<CR>', { desc = 'Next tab' })
    vim.keymap.set('n', '<leader>tp', '<Cmd>BufferLineCyclePrev<CR>', { desc = 'Previous tab' })
    vim.keymap.set('n', '<leader>tc', '<Cmd>bd<CR>', { desc = 'Close tab' })
    vim.keymap.set('n', '<leader>t<', '<Cmd>BufferLineMovePrev<CR>', { desc = 'Move tab left' })
    vim.keymap.set('n', '<leader>t>', '<Cmd>BufferLineMoveNext<CR>', { desc = 'Move tab right' })
    local macchiato = require('catppuccin.palettes').get_palette 'macchiato'
    require('bufferline').setup {
      highlights = require('catppuccin.groups.integrations.bufferline').get_theme {
        styles = { 'italic', 'bold' },
        custom = {
          -- macchiato = {
          --   fill = { bg = macchiato.surface0 },
          --   background = { bg = macchiato.surface0 },
          -- },
        },
        always_show_bufferline = true,
        show_close_icon = true,
        show_tab_indicators = true,
        separator_style = 'thick',
        hover = {
          enabled = true,
          delay = 120,
          reveal = { 'close' },
        },
      },
    }
  end,
  -- ---@module 'bufferline'
  -- ---@type bufferline.Config
  -- opts = {
  --   options = {
  --     always_show_bufferline = true,
  --     separator_style = 'thick',
  --     hover = {
  --       enabled = true,
  --       delay = 120,
  --       reveal = { 'close' },
  --     },
  --   },
  -- },
}
