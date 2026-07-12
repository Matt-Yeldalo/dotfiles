local meta = {
  name = "cozy_dark",
  background = "dark",
}

-- A warmer, cozier take on onedark_dark.
-- Shifts the palette from cool/neutral tones to warm amber/parchment tones.
local default_colors = {
  bg = "#1e1b17",       -- dark walnut (vs pure black)
  fg = "#c8b99a",       -- warm parchment (vs cool gray-blue)
  red = "#e07868",      -- coral terracotta
  orange = "#e0a060",   -- warm amber
  yellow = "#d4a855",   -- warm gold
  green = "#8ab878",    -- muted sage
  cyan = "#48a8a0",     -- warm teal
  blue = "#6aaedc",     -- soft steel blue
  purple = "#be7ec8",   -- muted mauve/heather
  white = "#c8b99a",
  black = "#1e1b17",
  gray = "#4a4038",     -- warm brownish-gray
  highlight = "#d4a840",
  comment = "#7a7060",  -- warm muted brown-gray
  none = "NONE",
}

---Colors which are generated depending on the values in the palette
---@param colors table the theme's color palette
---@return table
local function generate(colors)
  local color = require("onedarkpro.helpers")

  return {
    cursorline = colors.cursorline or color.lighten(colors.bg, 9),
    color_column = colors.color_column or color.lighten(colors.bg, 8.8),
    fold = colors.fold or color.lighten(colors.bg, 7),
    line_number = colors.line_number or "#5a5044",
    indentline = colors.indentline or color.lighten(colors.bg, 12),
    selection = colors.selection or color.lighten(colors.bg, 13),
    float_bg = colors.float_bg or color.darken(colors.bg, 3),
    inlay_hint = colors.inlay_hint or color.darken(colors.gray, 7),

    -- Git colors (for sign column)
    git_add = colors.git_add or color.darken(colors.green, 35),
    git_change = colors.git_change or color.darken(colors.yellow, 30),
    git_delete = colors.git_delete or color.darken(colors.red, 35),

    -- Diff colors (for diff mode backgrounds)
    diff_add = colors.diff_add or color.blend(colors.bg, colors.green, 0.12),
    diff_change = colors.diff_change or color.blend(colors.bg, colors.yellow, 0.10),
    diff_delete = colors.diff_delete or color.blend(colors.bg, colors.red, 0.12),
    diff_text = colors.diff_text or color.blend(colors.bg, colors.cyan, 0.25),
    diff_text_delete = colors.diff_text_delete or color.blend(colors.bg, colors.red, 0.25),

    -- Lualine colors
    bg_statusline = colors.bg_statusline or color.lighten(colors.bg, 5.3),
    fg_gutter = colors.fg_gutter or color.lighten(colors.bg, 9.5),
    fg_gutter_inactive = colors.fg_gutter_inactive or colors.fg,

    -- Virtual text
    virtual_text_error = colors.virtual_text_error or color.lighten(colors.red, 9.3),
    virtual_text_warning = colors.virtual_text_warning or color.lighten(colors.yellow, 9),
    virtual_text_information = colors.virtual_text_information or color.lighten(colors.blue, 10.2),
    virtual_text_hint = colors.virtual_text_hint or color.lighten(colors.cyan, 10.8),
  }
end

return {
  meta = meta,
  palette = default_colors,
  generated = function()
    return generate(default_colors)
  end,
}
