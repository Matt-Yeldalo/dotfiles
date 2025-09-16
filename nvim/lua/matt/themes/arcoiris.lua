local colors = {
  black = "#333333",       -- palette 0
  red = "#da2700",         -- palette 1
  green = "#12c258",       -- palette 2
  yellow = "#ffc656",      -- palette 3
  blue = "#518bfc",        -- palette 4
  magenta = "#e37bd9",     -- palette 5
  cyan = "#63fad5",        -- palette 6
  white = "#bab2b2",       -- palette 7
  bright_black = "#777777",-- palette 8
  bright_red = "#ffb9b9",  -- palette 9
  bright_green = "#e3f6aa",-- palette 10
  bright_yellow = "#ffddaa",-- palette 11
  bright_blue = "#b3e8f3", -- palette 12
  bright_magenta = "#cbbaf9", -- palette 13
  bright_cyan = "#bcffc7", -- palette 14
  bright_white = "#efefef",-- palette 15
  bg = "#201f1e",          -- background
  fg = "#eee4d9",          -- foreground
  cursor = "#7a1c1c",      -- cursor-color
  selection_bg = "#25524a",-- selection-background
  selection_fg = "#f3fffd",-- selection-foreground
}

local function set_highlights()
  local hl = vim.api.nvim_set_hl

  -- Editor UI
  hl(0, "Normal", { fg = colors.fg, bg = colors.bg })
  hl(0, "Cursor", { fg = colors.bg, bg = colors.cursor })
  hl(0, "Visual", { bg = colors.selection_bg, fg = colors.selection_fg })
  hl(0, "CursorLine", { bg = "#2c2929" }) -- Slightly brighter background
  hl(0, "LineNr", { fg = colors.bright_black })
  hl(0, "CursorLineNr", { fg = colors.bright_yellow, bold = true })
  hl(0, "StatusLine", { fg = colors.fg, bg = colors.black })
  hl(0, "StatusLineNC", { fg = colors.bright_black, bg = colors.black })
  hl(0, "VertSplit", { fg = colors.bright_black })
  hl(0, "Pmenu", { bg = colors.black, fg = colors.fg })
  hl(0, "PmenuSel", { bg = colors.selection_bg, fg = colors.selection_fg })

  -- Syntax Highlighting
  hl(0, "Comment", { fg = colors.bright_black, italic = true })
  hl(0, "Constant", { fg = colors.bright_red })
  hl(0, "String", { fg = colors.green })
  hl(0, "Character", { fg = colors.green })
  hl(0, "Number", { fg = colors.yellow })
  hl(0, "Boolean", { fg = colors.red, bold = true })
  hl(0, "Function", { fg = colors.blue })
  hl(0, "Keyword", { fg = colors.magenta, bold = true })
  hl(0, "Variable", { fg = colors.fg })
  hl(0, "Type", { fg = colors.cyan, bold = true })
  hl(0, "Error", { fg = colors.bright_red, bg = colors.bg, bold = true })

  -- Diagnostics
  hl(0, "DiagnosticError", { fg = colors.red })
  hl(0, "DiagnosticWarn", { fg = colors.yellow })
  hl(0, "DiagnosticInfo", { fg = colors.blue })
  hl(0, "DiagnosticHint", { fg = colors.cyan })
end

set_highlights()

