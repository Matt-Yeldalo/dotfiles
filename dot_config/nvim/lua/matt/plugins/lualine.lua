-- Copyright (c) 2020-2021 shadmansaleh
-- MIT license, see LICENSE for more details.
-- Credit: Zoltan Dalmadi(lightline)
-- stylua: ignore
-- local colors = {
--   blue   = '#61afef',
--   green  = '#98c379',
--   purple = '#c678dd',
--   cyan   = '#56b6c2',
--   red1   = '#e06c75',
--   red2   = '#be5046',
--   yellow = '#e5c07b',
--   fg     = '#abb2bf',
--   bg     = '#282c34',
--   gray1  = '#828997',
--   gray2  = '#2c323c',
--   gray3  = '#3e4452',
-- }

local onedark_dark_colors = {
    bg = "#000000",
    fg = "#abb2bf",
    red = "#ef596f",
    orange = "#d19a66",
    yellow = "#e5c07b",
    green = "#89ca78",
    cyan = "#2bbac5",
    blue = "#61afef",
    purple = "#d55fde",
    white = "#abb2bf",
    black = "#000000",
    gray = "#434852",
    highlight = "#e2be7d",
    comment = "#7f848e",
}

local function patternescape(str)
  return str:gsub('[%(%)%.%%%+%-%*%?%[%]%^%$]', '%%%1')
end

local function array(...)
  local t = {}
  for x in ... do
    t[#t + 1] = x
  end
  return t
end

local function split(str, sep)
  if not sep then
    return array(str:gmatch '([%S]+)')
  else
    assert(sep ~= '', 'empty separator')
    local psep = patternescape(sep)
    return array((str .. sep):gmatch('(.-)(' .. psep .. ')'))
  end
end

-- local config = require 'matt.config.onedarkpro'

local function onedark_dark()
  local onedarkpro = {}
  local colors = onedark_dark_colors

  onedarkpro.normal = {
    a = { bg = colors.green, fg = colors.bg },
    b = { bg = colors.fg_gutter, fg = colors.green },
    c = { bg = colors.none or colors.bg_statusline, fg = colors.fg },
  }

  onedarkpro.insert = {
    a = { bg = colors.blue, fg = colors.bg },
    b = { bg = colors.fg_gutter, fg = colors.blue },
  }

  onedarkpro.command = {
    a = { bg = colors.purple, fg = colors.bg },
    b = { bg = colors.fg_gutter, fg = colors.purple },
  }

  onedarkpro.visual = {
    a = { bg = colors.yellow, fg = colors.bg },
    b = { bg = colors.fg_gutter, fg = colors.yellow },
  }

  onedarkpro.replace = {
    a = { bg = colors.red, fg = colors.bg },
    b = { bg = colors.fg_gutter, fg = colors.red },
  }

  local inactive_bg = colors.color_column or colors.bg
  onedarkpro.inactive = {
    a = { bg = inactive_bg, fg = colors.blue },
    b = { bg = inactive_bg, fg = colors.fg_gutter_inactive, gui = 'bold' },
    c = { bg = colors.none or inactive_bg, fg = colors.fg_gutter_inactive },
  }

  return onedarkpro
end
local function default_onedark()
  local colors = {
    blue = '#61afef',
    green = '#98c379',
    purple = '#c678dd',
    cyan = '#56b6c2',
    red1 = '#e06c75',
    red2 = '#be5046',
    yellow = '#e5c07b',
    fg = '#abb2bf',
    bg = 'black',
    gray1 = '#828997',
    gray2 = '#2c323c',
    gray3 = '#3e4452',
  }

  return {
    normal = {
      a = { fg = colors.bg, bg = colors.green, gui = 'bold' },
      b = { fg = colors.fg, bg = colors.gray2 },
      c = { fg = colors.fg, bg = colors.blue },
    },
    command = { a = { fg = colors.bg, bg = colors.yellow, gui = 'bold' } },
    insert = { a = { fg = colors.bg, bg = colors.blue, gui = 'bold' } },
    visual = { a = { fg = colors.bg, bg = colors.purple, gui = 'bold' } },
    terminal = { a = { fg = colors.bg, bg = colors.cyan, gui = 'bold' } },
    replace = { a = { fg = colors.bg, bg = colors.red1, gui = 'bold' } },
    inactive = {
      a = { fg = colors.gray1, bg = colors.bg, gui = 'bold' },
      b = { fg = colors.gray1, bg = colors.bg },
      c = { fg = colors.gray1, bg = colors.gray3 },
    },
  }
end

local icons = require 'matt.icons'
-- local custom_ondarkpro = require 'lualine.themes.onedark'
local colors = {
  bg = '#000000',
  fg = '#bbc2cf',
  yellow = '#ECBE7B',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#98be65',
  orange = '#FF8800',
  violet = '#a9a1e1',
  magenta = '#c678dd',
  blue = '#51afef',
  red = '#ec5f67',
}
-- custom_ondarkpro.normal.c.bg = colors.bg

local mode_color = {
  n = colors.green,
  i = colors.blue,
  v = colors.magenta,
  [''] = colors.magenta,
  V = colors.magenta,
  c = colors.yellow,
  t = colors.red,
  R = colors.orange,
  Rv = colors.orange,
  no = colors.fg,
  s = colors.violet,
  S = colors.violet,
  [''] = colors.violet,
  ic = colors.yellow,
  cv = colors.red,
  ce = colors.red,
  r = colors.cyan,
  rm = colors.cyan,
  ['r?'] = colors.cyan,
  ['!'] = colors.red,
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand '%:t') ~= 1
  end,
  buffer_is_file = function()
    return vim.bo.buftype == ''
  end,
  buffer_not_scratch = function()
    return string.find(vim.fn.bufname(), 'SCRATCH') == nil
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand '%:p:h'
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}
local searchcount = { 'searchcount', color = { fg = colors.fg, gui = 'bold' } }
local selectioncount = { 'selectioncount', color = { fg = colors.fg, gui = 'bold' } }
local progress = { 'progress', color = { fg = colors.fg, gui = 'bold' } }
local filetype = { 'filetype', color = { fg = colors.blue, gui = 'bold' } }
local filesize = { 'filesize', color = { fg = colors.fg, gui = 'bold' }, cond = conditions.buffer_not_empty }
local fileformat = { 'fileformat', icons_enabled = true, color = { fg = colors.white, gui = 'bold' } }

local filename = {
  'filename',
  cond = conditions.buffer_not_empty and conditions.buffer_is_file and conditions.buffer_not_scratch,
  color = { fg = colors.magenta, gui = 'bold' },
}

local buffers = {
  'buffers',
  mode = 2,
  cond = conditions.buffer_not_scratch,
  filetype_names = {
    TelescopePrompt = icons.ui.Telescope .. 'Telescope',
    dashboard = icons.ui.Dashboard .. 'Dashboard',
    lazy = icons.ui.Sleep .. 'Lazy',
    mason = icons.ui.Package .. 'Mason',
    NvimTree = icons.documents.OpenFolder .. 'Files',
    spectre_panel = icons.ui.Search .. 'Spectre',
  },
  use_mode_colors = true,
}

local branch = {
  'branch',
  icon = icons.git.Branch,
  fmt = function(str)
    return str:sub(1, 32)
  end,
  color = { fg = colors.green, gui = 'bold' },
}

local diff_icons = {
  'diff',
  symbols = { added = icons.git.AddAlt, modified = icons.git.DiffAlt, removed = icons.git.RemoveAlt },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}

local diagnostics = {
  'diagnostics',
  sources = { 'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic' },
  symbols = {
    error = icons.diagnostics.Error,
    warn = icons.diagnostics.Warning,
    info = icons.diagnostics.Information,
    hint = icons.diagnostics.Hint,
  },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.blue },
    color_hint = { fg = colors.yellow },
  },
}

local lsp = {
  function()
    local msg = 'No LSP'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = icons.ui.Gear,
  color = { fg = colors.fg, gui = 'bold' },
}

local encoding = {
  'o:encoding',
  fmt = string.upper,
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = 'bold' },
}

local separator = {
  function()
    return icons.ui.Separator
  end,
  color = function()
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { left = 0, right = 0 },
}

local project = {
  function()
    return icons.ui.Project
  end,
  color = function()
    return { fg = colors.blue }
  end,
  fmt = function(str)
    local root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'Gemfile' }, { upward = true })[1])
    if root_dir == nil then
      return str
    end

    return str .. root_dir
  end,
}

local function mode(icon)
  icon = icon or icons.ui.Neovim
  return {
    function()
      return icon
    end,
    color = function()
      return { fg = mode_color[vim.fn.mode()] }
    end,
    padding = { left = 1, right = 0 },
  }
end

return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup {
      options = {
        component_separators = '',
        -- section_separators = '',
        -- theme = 'onedark_dark',
        theme = onedark_dark(),
        disabled_filetypes = {
          'dashboard',
        },
      },
      -- extensions = { 'quickfix', 'man', 'mason', 'lazy', 'toggleterm', 'nvim-tree' },
      extensions = { 'quickfix', 'nvim-tree' },
      tabline = {
        lualine_a = {},
        -- lualine_b = { mode(), buffers },
        lualine_b = { mode(), project },
        lualine_c = {},
        lualine_x = { diff_icons, branch },
        lualine_y = { searchcount, selectioncount },
        lualine_z = {},
      },
      sections = {
        lualine_a = {},
        lualine_b = { separator, mode(icons.ui.Heart), 'location', progress, filename },
        lualine_c = {},
        lualine_x = { diagnostics, lsp, filetype, filesize, fileformat, encoding, separator },
        lualine_y = {},
        lualine_z = {},
      },
    }
  end,
  event = { 'BufReadPost', 'BufNewFile' },
}
