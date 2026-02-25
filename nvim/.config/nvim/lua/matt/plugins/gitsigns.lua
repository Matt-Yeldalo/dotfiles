-- Adds git related signs to the gutter, as well as utilities for managing changes
-- NOTE: gitsigns is already included in init.lua but contains only the base
-- config. This will add also the recommended keymaps.
return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('gitsigns').setup {
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '▎' },
        topdelete = { text = '▎' },
        changedelete = { text = '▎' },
      },
    }
  end,
  keys = {
    { ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<cr>'", expr = true, desc = 'Next hunk' },
    { '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<cr>'", expr = true, desc = 'Prev hunk' },
    { '<leader>hs', '<cmd>Gitsigns stage_hunk<cr>', desc = 'Stage hunk' },
    { '<leader>hr', '<cmd>Gitsigns reset_hunk<cr>', desc = 'Reset hunk' },
    { '<leader>hS', '<cmd>Gitsigns stage_buffer<cr>', desc = 'Stage buffer' },
    { '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<cr>', desc = 'Undo stage hunk' },
    { '<leader>hR', '<cmd>Gitsigns reset_buffer<cr>', desc = 'Reset buffer' },
    { '<leader>hb', '<cmd>Gitsigns blame_line<cr>', desc = 'Blame line' },
    { '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<cr>', desc = 'Toggle current line blame' },
     { '<leader>td', '<cmd>Gitsigns toggle_deleted<cr>', desc = 'Toggle deleted' },
  },
}
