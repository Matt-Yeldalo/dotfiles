return {
  'matt-yeldalo/rails-schema.nvim',
  ft = 'ruby',
  config = function()
    require('rails-schema').setup {
      border = 'rounded',
      width = 0.6,
      height = 0.6,
      environment = 'development',
    }

    vim.keymap.set('n', '<leader>rs', '<cmd>RailsSchema<cr>', {
      desc = 'Toggle Rails schema',
    })
  end,
}
