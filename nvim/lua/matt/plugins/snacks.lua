return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  keys = {
    -- Zen
    {
      '<leader>zz',
      mode = { 'n', 'x', 'o' },
      function()
        require('snacks').zen()
      end,
      desc = 'Toggle [Z]en mode',
    },
    -- Flash
    {
      '<leader>j',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash',
    },
    {
      '<leader>J',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash Treesitter',
    },
    {
      'r',
      mode = 'o',
      function()
        require('flash').remote()
      end,
      desc = 'Remote Flash',
    },
    {
      'R',
      mode = { 'o', 'x' },
      function()
        require('flash').treesitter_search()
      end,
      desc = 'Treesitter Search',
    },
    {
      '<c-s>',
      mode = { 'c' },
      function()
        require('flash').toggle()
      end,
      desc = 'Toggle Flash Search',
    },
    -- Top Pickers & Explorer
    {
      '<leader><space>',
      function()
        require('snacks').picker.smart()
      end,
      desc = 'Smart Find Files',
    },
    {
      '<leader>,',
      function()
        require('snacks').picker.buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>/',
      function()
        require('snacks').picker.grep()
      end,
      desc = 'Grep',
    },
    {
      '<leader>:',
      function()
        require('snacks').picker.command_history()
      end,
      desc = 'Command History',
    },
    {
      '<leader>n',
      function()
        require('snacks').picker.notifications()
      end,
      desc = 'Notification History',
    },
    {
      '<leader>e',
      function()
        require('snacks').explorer()
      end,
      desc = 'File Explorer',
    },
    -- find
    {
      '<leader>fb',
      function()
        require('snacks').picker.buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>fc',
      function()
        require('snacks').picker.files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = 'Find Config File',
    },
    {
      '<leader>ff',
      function()
        require('snacks').picker.files()
      end,
      desc = 'Find Files',
    },
    {
      '<leader>fg',
      function()
        require('snacks').picker.git_files()
      end,
      desc = 'Find Git Files',
    },
    {
      '<leader>fp',
      function()
        require('snacks').picker.projects()
      end,
      desc = 'Projects',
    },
    {
      '<leader>fr',
      function()
        require('snacks').picker.recent()
      end,
      desc = 'Recent',
    },
    -- git
    {
      '<leader>gg',
      function()
        require('snacks').lazygit.open()
      end,
      desc = 'Git Branches',
    },
    {
      '<leader>gB',
      function()
        require('snacks').picker.git_branches()
      end,
      desc = 'Git Branches',
    },
    {
      '<leader>gb',
      function()
        require('snacks').git.blame_line()
      end,
      desc = 'Git Blame',
    },
    {
      '<leader>gl',
      function()
        require('snacks').picker.git_log()
      end,
      desc = 'Git Log',
    },
    {
      '<leader>gL',
      function()
        require('snacks').picker.git_log_line()
      end,
      desc = 'Git Log Line',
    },
    {
      '<leader>gs',
      function()
        require('snacks').picker.git_status()
      end,
      desc = 'Git Status',
    },
    {
      '<leader>gS',
      function()
        require('snacks').picker.git_stash()
      end,
      desc = 'Git Stash',
    },
    {
      '<leader>gd',
      function()
        require('snacks').picker.git_diff()
      end,
      desc = 'Git Diff (Hunks)',
    },
    {
      '<leader>gf',
      function()
        require('snacks').picker.git_log_file()
      end,
      desc = 'Git Log File',
    },
    -- Grep
    {
      '<leader>sb',
      function()
        require('snacks').picker.lines()
      end,
      desc = 'Buffer Lines',
    },
    {
      '<leader>sB',
      function()
        require('snacks').picker.grep_buffers()
      end,
      desc = 'Grep Open Buffers',
    },
    {
      '<leader>sg',
      function()
        require('snacks').picker.grep()
      end,
      desc = 'Grep',
    },
    {
      '<leader>sw',
      function()
        require('snacks').picker.grep_word()
      end,
      desc = 'Visual selection or word',
      mode = { 'n', 'x' },
    },
    -- search
    {
      '<leader>s"',
      function()
        require('snacks').picker.registers()
      end,
      desc = 'Registers',
    },
    {
      '<leader>s/',
      function()
        require('snacks').picker.search_history()
      end,
      desc = 'Search History',
    },
    {
      '<leader>sa',
      function()
        require('snacks').picker.autocmds()
      end,
      desc = 'Autocmds',
    },
    {
      '<leader>sb',
      function()
        require('snacks').picker.lines()
      end,
      desc = 'Buffer Lines',
    },
    {
      '<leader>sc',
      function()
        require('snacks').picker.command_history()
      end,
      desc = 'Command History',
    },
    {
      '<leader>sC',
      function()
        require('snacks').picker.commands()
      end,
      desc = 'Commands',
    },
    {
      '<leader>sd',
      function()
        require('snacks').picker.diagnostics()
      end,
      desc = 'Diagnostics',
    },
    {
      '<leader>sD',
      function()
        require('snacks').picker.diagnostics_buffer()
      end,
      desc = 'Buffer Diagnostics',
    },
    {
      '<leader>sh',
      function()
        require('snacks').picker.help()
      end,
      desc = 'Help Pages',
    },
    {
      '<leader>sH',
      function()
        require('snacks').picker.highlights()
      end,
      desc = 'Highlights',
    },
    {
      '<leader>si',
      function()
        require('snacks').picker.icons()
      end,
      desc = 'Icons',
    },
    {
      '<leader>sj',
      function()
        require('snacks').picker.jumps()
      end,
      desc = 'Jumps',
    },
    {
      '<leader>sk',
      function()
        require('snacks').picker.keymaps()
      end,
      desc = 'Keymaps',
    },
    {
      '<leader>sl',
      function()
        require('snacks').picker.loclist()
      end,
      desc = 'Location List',
    },
    {
      '<leader>sm',
      function()
        require('snacks').picker.marks()
      end,
      desc = 'Marks',
    },
    {
      '<leader>sM',
      function()
        require('snacks').picker.man()
      end,
      desc = 'Man Pages',
    },
    {
      '<leader>sp',
      function()
        require('snacks').picker.lazy()
      end,
      desc = 'Search for Plugin Spec',
    },
    {
      '<leader>sq',
      function()
        require('snacks').picker.qflist()
      end,
      desc = 'Quickfix List',
    },
    {
      '<leader>sR',
      function()
        require('snacks').picker.resume()
      end,
      desc = 'Resume',
    },
    {
      '<leader>su',
      function()
        require('snacks').picker.undo()
      end,
      desc = 'Undo History',
    },
    {
      '<leader>uC',
      function()
        require('snacks').picker.colorschemes()
      end,
      desc = 'Colorschemes',
    },
    -- LSP
    {
      'gd',
      function()
        require('snacks').picker.lsp_definitions()
      end,
      desc = 'Goto Definition',
    },
    {
      'gD',
      function()
        require('snacks').picker.lsp_declarations()
      end,
      desc = 'Goto Declaration',
    },
    {
      'gr',
      function()
        require('snacks').picker.lsp_references()
      end,
      nowait = true,
      desc = 'References',
    },
    {
      'gI',
      function()
        require('snacks').picker.lsp_implementations()
      end,
      desc = 'Goto Implementation',
    },
    {
      'gT',
      function()
        require('snacks').picker.lsp_type_definitions()
      end,
      desc = 'Goto [T]ype Definition',
    },
    {
      '<leader>ss',
      function()
        require('snacks').picker.lsp_symbols()
      end,
      desc = 'LSP Symbols',
    },
    {
      '<leader>sS',
      function()
        require('snacks').picker.lsp_workspace_symbols()
      end,
      desc = 'LSP Workspace Symbols',
    },
  },
  config = function()
    local icons = require 'matt.icons'
    require('snacks').setup {
      picker = {},
      animate = {
        enabled = true,
        duration = 40, -- ms per step
        easing = function(time, begin, change, duration)
          return change * time / duration + begin
        end,
        fps = 60,
      },
      bigfile = {
        enabled = true,
        notify = true,
        size = 1.5 * 1024 * 1024,
      },
      bufdelete = { enabled = true },
      dashboard = {
        enabled = true,
        sections = {
          { section = 'header' },
          {
            icon = icons.ui.Keyboard,
            title = 'Keymaps',
            section = 'keys',
            indent = 2,
            padding = 1,
          },
          {
            icon = icons.documents.File,
            title = 'Recent Files',
            section = 'recent_files',
            indent = 2,
            padding = 1,
          },
          {
            icon = icons.documents.OpenFolder,
            title = 'Projects',
            section = 'projects',
            indent = 2,
            padding = 1,
          },
          { section = 'startup' },
        },
      },
      dim = {
        enabled = true,
        scope = {
          min_size = 5,
          max_size = 20,
          siblings = true,
        },
      },
      git = { enabled = true },
      gitbrowse = { enabled = true },
      indent = {
        enabled = true,
        priority = 1,
        char = icons.ui.SeparatorLight,
        only_scope = false,
        only_current = false,
        hl = {
          "require('snacks')Indent1",
          "require('snacks')Indent2",
          "require('snacks')Indent3",
          "require('snacks')Indent4",
          "require('snacks')Indent5",
          "require('snacks')Indent6",
          "require('snacks')Indent7",
          "require('snacks')Indent8",
        },
      },
      image = {
        force = true,
      },
      input = {
        enabled = true,
        icon = icons.ui.Edit,
        icon_hl = "require('snacks')InputIcon",
        icon_pos = 'left',
        prompt_pos = 'title',
        win = { style = 'input' },
        expand = true,
      },
      lazygit = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 1000,
        width = { min = 40, max = 0.4 },
        height = { min = 1, max = 0.6 },
        margin = { top = 0, right = 1, bottom = 0 },
        padding = true,
        sort = { 'level', 'added' },
        level = vim.log.levels.TRACE,
        icons = {
          debug = icons.ui.Bug,
          error = icons.diagnostics.Error,
          info = icons.diagnostics.Information,
          trace = icons.ui.Bookmark,
          warn = icons.diagnostics.Warning,
        },
        style = 'compact',
        top_down = true,
        date_format = '%R',
        more_format = ' ↓ %d lines ',
        refresh = 50,
      },
      notify = { enabled = true },
      quickfile = { enabled = true },
      rename = { enabled = true },
      scope = {
        enabled = true,
        keys = {
          textobject = {
            ii = {
              min_size = 2, -- minimum size of the scope
              edge = false, -- inner scope
              cursor = false,
              treesitter = { blocks = { enabled = false } },
              desc = 'inner scope',
            },
            ai = {
              cursor = false,
              min_size = 2, -- minimum size of the scope
              treesitter = { blocks = { enabled = false } },
              desc = 'full scope',
            },
          },
          jump = {
            ['[a'] = {
              min_size = 1, -- allow single line scopes
              bottom = false,
              cursor = false,
              edge = true,
              treesitter = { blocks = { enabled = false } },
              desc = 'jump to top edge of scope',
            },
            [']a'] = {
              min_size = 1, -- allow single line scopes
              bottom = true,
              cursor = false,
              edge = true,
              treesitter = { blocks = { enabled = false } },
              desc = 'jump to bottom edge of scope',
            },
          },
        },
      },
      win = {
        width = 0.9,
        height = 0.9,
        bo = { buftype = '', buflisted = false, bufhidden = 'hide', swapfile = false },
        minimal = false,
        noautocmd = false,
        zindex = 20,
        wo = { winhighlight = 'NormalFloat:Normal' },
        border = 'rounded',
        title_pos = 'center',
        footer_pos = 'center',
        relative = 'editor',
        keys = {
          ['execute'] = {
            'M<cr>',
            function(_)
              vim.cmd '%SnipRun'
            end,
            desc = 'Execute buffer',
            mode = { 'n', 'x' },
          },
        },
      },
      -- win_by_ft = {
      --   lua = {
      --     keys = {
      --       ['source'] = {
      --         '<cr>',
      --         function(self)
      --           local name = 'scratch.' .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.buf), ':e')
      --           require('snacks').debug.run { buf = self.buf, name = name }
      --         end,
      --         desc = 'Source buffer',
      --         mode = { 'n', 'x' },
      --       },
      --       ['execute'] = {
      --         'e',
      --         function(_)
      --           vim.cmd '%SnipRun'
      --         end,
      --         desc = 'Execute buffer',
      --         mode = { 'n', 'x' },
      --       },
      --     },
      --   },
      -- },
      scroll = { enabled = false },
      statuscolumn = {
        enabled = true,
        left = { 'mark', 'sign' },
        right = { 'fold', 'git' },
        folds = {
          open = true,
          git_hl = true,
        },
        git = {
          patterns = { 'GitSign', 'MiniDiffSign' },
        },
        refresh = 50,
      },
      terminal = { enabled = true },
      toggle = { enabled = true },
      words = { enabled = true },
      zen = {
        enabled = true,
        toggles = {
          dim = true,
          git_signs = false,
          mini_diff_signs = false,
          diagnostics = false,
          -- inlay_hints = false,
        },
        show = {
          statusline = false,
          tabline = false,
        },
        win = { style = 'zen' },
        zoom = {
          toggles = {},
          show = { statusline = true, tabline = true },
          win = {
            backdrop = false,
            width = 0,
          },
        },
      },
    }
  end,
}
