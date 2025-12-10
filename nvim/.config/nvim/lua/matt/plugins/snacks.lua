return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    lazygit = {},
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = {
      enabled = true,
      sources = {
        files = {
          hidden = true,
        },
        explorer = {
          hidden = true,
        },
      },
    },
    quickfile = { enabled = true },
    scroll = {
      enabled = true,
      -- enabled = false,
      -- duration = { step = 10, total = 100 }, -- faster animation (default 150)
      -- easing = 'linear',
      duration = { step = 1, total = 10 },
    },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    -- Explorer
    {
      '\\',
      function()
        Snacks.picker.explorer()
      end,
      desc = 'File Explorer',
    },
    -- Git
    {
      '<leader>gB',
      function()
        Snacks.gitbrowse()
      end,
      desc = 'Git Browse',
      mode = { 'n', 'v' },
    },
    {
      '<leader>gb',
      function()
        Snacks.git.blame_line()
      end,
      desc = 'Git Blame Line',
    },
    {
      '<leader>gf',
      function()
        Snacks.lazygit.log_file()
      end,
      desc = 'Lazygit Current File History',
    },
    {
      '<leader>gg',
      function()
        Snacks.lazygit()
      end,
      desc = 'Lazygit',
    },
    {
      '<leader>gl',
      function()
        Snacks.lazygit.log()
      end,
      desc = 'Lazygit Log (cwd)',
    },
    -- Search
    {
      '<leader>sh',
      function()
        Snacks.picker.help()
      end,
      desc = '[S]earch [H]elp',
    },
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = '[S]earch [K]eymaps',
    },
    {
      '<leader>sf',
      function()
        Snacks.picker.files()
      end,
      desc = '[S]earch [F]iles',
    },
    {
      '<leader>sw',
      function()
        Snacks.picker.grep_word()
      end,
      desc = '[S]earch current [W]ord',
    },
    {
      '<leader>sg',
      function()
        Snacks.picker.grep()
      end,
      desc = '[S]earch by [G]rep',
    },
    {
      '<leader>sd',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = '[S]earch [D]iagnostics',
    },
    {
      '<leader>sr',
      function()
        Snacks.picker.resume()
      end,
      desc = '[S]earch [R]esume',
    },
    {
      '<leader><leader>',
      function()
        Snacks.picker.recent()
      end,
      desc = '[ ] Search Recent Files',
    },
    {
      '<leader>s.',
      function()
        Snacks.picker.buffers()
      end,
      desc = '[S]earch Buffers',
    },
    {
      '<leader>/',
      function()
        Snacks.picker.lines()
      end,
      desc = '[/] Fuzzily search in current buffer',
    },
    {
      '<leader>s/',
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = '[S]earch [/] in Open Files',
    },
    {
      '<leader>sn',
      function()
        Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = '[S]earch [N]eovim files',
    },
    -- Rails
    {
      '<leader>sv',
      function()
        Snacks.picker.files { cwd = vim.fs.dirname(vim.fs.find({ '.git', 'Gemfile' }, { upward = true })[1]) .. '/app/views' }
      end,
      desc = '[S]earch [V]iews',
    },
    {
      '<leader>sc',
      function()
        Snacks.picker.files { cwd = vim.fs.dirname(vim.fs.find({ '.git', 'Gemfile' }, { upward = true })[1]) .. '/app/controllers' }
      end,
      desc = '[S]earch [C]ontrollers',
    },
    {
      '<leader>sm',
      function()
        Snacks.picker.files { cwd = vim.fs.dirname(vim.fs.find({ '.git', 'Gemfile' }, { upward = true })[1]) .. '/app/models' }
      end,
      desc = '[S]earch [M]odels',
    },
    {
      '<leader>sj',
      function()
        Snacks.picker.files { cwd = vim.fs.dirname(vim.fs.find({ '.git', 'Gemfile' }, { upward = true })[1]) .. '/app/javascript' }
      end,
      desc = '[S]earch [J]avascript',
    },
    {
      '<leader>ss',
      function()
        Snacks.picker.files { cwd = vim.fs.dirname(vim.fs.find({ '.git', 'Gemfile' }, { upward = true })[1]) .. '/app/assets/stylesheets' }
      end,
      desc = '[S]earch [S]tylesheets',
    },
    {
      '<leader>sa',
      function()
        Snacks.picker.files { cwd = vim.fs.dirname(vim.fs.find({ '.git', 'Gemfile' }, { upward = true })[1]) .. '/app/components' }
      end,
      desc = '[S]earch Components',
    },
  },
}
