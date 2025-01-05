local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Afterglow (Gogh)"

config.audible_bell = "Disabled"
config.bold_brightens_ansi_colors = true
config.enable_tab_bar = true
config.window_decorations = "TITLE | RESIZE"
-- Home/Windows
config.window_frame = {
	font = wezterm.font({ family = "CommitMono", weight = "Bold" }),
	inactive_titlebar_bg = "#353535",
	active_titlebar_bg = "#2b2042",
	inactive_titlebar_fg = "#cccccc",
	active_titlebar_fg = "#ffffff",
	inactive_titlebar_border_bottom = "#2b2042",
	active_titlebar_border_bottom = "#2b2042",
	button_fg = "#cccccc",
	button_bg = "#2b2042",
	button_hover_fg = "#ffffff",
	button_hover_bg = "#3b3052",
}
-- Fonts
config.font =
	wezterm.font({ family = "MapleMonoNF", weight = "Medium", harfbuzz_features = { "calt=0", "clig=0", "liga=0" } })
config.font_size = 19
config.line_height = 1.3
config.freetype_load_target = "Light"
config.freetype_load_flags = "NO_HINTING"
-- Remaps
config.keys = {
	{
		key = "F1",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		key = "F2",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "UpArrow",
		mods = "CTRL",
		action = wezterm.action.ScrollByPage(-0.2),
	},
	{
		key = "DownArrow",
		mods = "CTRL",
		action = wezterm.action.ScrollByPage(0.2),
	},
}

-- config.default_domain = "WSL:Ubuntu"
-- config.colors = {
-- 	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
-- 	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
-- }
config.colors = {
	tab_bar = {
		-- The color of the strip that goes along the top of the window
		-- (does not apply when fancy tab bar is in use)
		background = "#ffffff",
		-- The active tab is the one that has focus in the window
		active_tab = {
			-- The color of the background area for the tab
			bg_color = "#333",
			-- The color of the text for the tab
			fg_color = "#ddd",
			-- Specify whether you want "Half", "Normal" or "Bold" intensity for the
			-- label shown for this tab.
			-- The default is "Normal"
			intensity = "Bold",
			-- Specify whether you want "None", "Single" or "Double" underline for
			-- label shown for this tab.
			-- The default is "None"
			underline = "None",
			-- Specify whether you want the text to be italic (true) or not (false)
			-- for this tab.  The default is false.
			italic = false,
			-- Specify whether you want the text to be rendered with strikethrough (true)
			-- or not for this tab.  The default is false.
			strikethrough = false,
		},
		-- Inactive tabs are the tabs that do not have focus
		inactive_tab = {
			bg_color = "#111",
			fg_color = "#999",
			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `inactive_tab`.
		},
		-- You can configure some alternate styling when the mouse pointer
		-- moves over inactive tabs
		inactive_tab_hover = {
			bg_color = "#3b3052",
			fg_color = "#909090",
			italic = true,
			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `inactive_tab_hover`.
		},
		-- The new tab button that let you create new tabs
		new_tab = {
			bg_color = "#1b1032",
			fg_color = "#808080",
			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `new_tab`.
		},
		-- You can configure some alternate styling when the mouse pointer
		-- moves over the new tab button
		new_tab_hover = {
			bg_color = "#3b3052",
			fg_color = "#909090",
			italic = true,
			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `new_tab_hover`.
		},
	},
}
return config
