local icons = require 'matt.icons'
return {
  'nvimdev/lspsaga.nvim',
  config = function()
    vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>')
    vim.keymap.set('n', '<leader>pd', '<cmd>Lspsaga peek_definition<CR>', { desc = '[LSP] [P]eek [D]efinition' })
    vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { desc = '[LSP] Hover Doc' })
    return require('lspsaga').setup {
      lightbulb = { enable = false },
      ui = {
        theme = 'round',
        border = 'rounded',
        devicon = true,
        title = true,
        winblend = 1,
        expand = icons.ui.ArrowOpen,
        collapse = icons.ui.ArrowClosed,
        preview = icons.ui.List,
        code_action = icons.diagnostics.Hint,
        diagnostic = icons.ui.Bug,
        incoming = icons.ui.Incoming,
        outgoing = icons.ui.Outgoing,
        hover = icons.ui.Comment,
      },
    }
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
}
