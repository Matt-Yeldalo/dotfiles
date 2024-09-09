local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- config.default_domain = "WSL:Ubuntu"

config.window_frame = {
	font = wezterm.font({ family = "MartianMono Nerd Font", weight = "Bold" }),
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

config.keys = {
	{
		key = 'F1',
		action = wezterm.action.TogglePaneZoomState
	},
	{
		key = 'F2',
		action = wezterm.action.ToggleFullScreen
	}
}

config.colors = {
ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}

config.color_scheme = "Afterglow (Gogh)"
config.font = wezterm.font({
family = "MartianMono Nerd Font",
weight = "Medium",
})
config.window_background_opacity = 0.9
-- config.macos_window_background_blur = 8
-- config.win32_system_backdrop = "Acrylic"
-- config.win32_acrylic_accent_color = "#447799"
config.bold_brightens_ansi_colors = true
config.font_size = 14
config.line_height = 1.2
config.enable_tab_bar = false
config.window_decorations = "TITLE | RESIZE"

return config
