--          ╭─────────────────────────────────────────────────────────╮
--          │                     Wezterm Config                      │
--          ╰─────────────────────────────────────────────────────────╯

local wezterm = require("wezterm")
local opacity = 0.75
local colors = require("colors.custom")

return {
	--                                                           ▲
	--   General                                                 █
	--                                                           ▼
	enable_wayland = false,
	font_size = 14.0,
	font = wezterm.font("JetBrains Mono"),
	--                                                           ▲
	--   Window                                                  █
	--                                                           ▼
	initial_rows = 45,
	initial_cols = 180,
	window_decorations = "RESIZE",
	window_background_opacity = opacity,
	window_close_confirmation = "NeverPrompt",
	max_fps = 60,
	cursor_blink_rate = 250,
	--                                                           ▲
	--   Colors                                                  █
	--                                                           ▼
	colors = colors,
	force_reverse_video_cursor = true,
	--                                                           ▲
	--   Tabs                                                    █
	--                                                           ▼
	enable_tab_bar = false,
	--                                                           ▲
	--   Keybindings                                             █
	--                                                           ▼
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
