--          ╭─────────────────────────────────────────────────────────╮
--          │                     Wezterm Config                      │
--          ╰─────────────────────────────────────────────────────────╯

local wezterm = require("wezterm")
local opacity = 0.75
local colors = require("colors.custom")
require("events")

return {
	--
	--   General
	--
	enable_wayland = false,
	warn_about_missing_glyphs = false,
	font_size = 14,
	font = wezterm.font_with_fallback({
		{ family = "Lilex Nerd Font Mono" },
		{ family = "JetBrainsMono Nerd Font Mono" },
		{ family = "Symbols Nerd Font Mono" },
	}),
	harfbuzz_features = { "liga=1" },
	--
	--   Window
	--
	window_padding = {
		left = 5,
		right = 5,
		top = 5,
		bottom = 5,
	},
	underline_position = -6,
	underline_thickness = "250%",
	initial_rows = 25,
	initial_cols = 120,
	window_decorations = "RESIZE",
	window_background_opacity = opacity,
	window_close_confirmation = "NeverPrompt",
	max_fps = 60,
	cursor_blink_rate = 250,
	inactive_pane_hsb = {
		saturation = 1.0,
		brightness = 1.0,
	},
	--
	--   Colors
	--
	colors = colors,
	force_reverse_video_cursor = true,
	--
	--   Tabs
	--
	enable_tab_bar = false,
	--
	--   Keybindings
	--
	keys = {
		{
			key = "f",
			mods = "CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
		{
			key = "'",
			mods = "CTRL",
			action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
		},
	},
	mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
}
