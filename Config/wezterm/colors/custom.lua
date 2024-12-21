-- A slightly altered version of catppucchin mocha
local mocha = {
	rosewater = "#ea6962",
	flamingo = "#ea6962",
	red = "#ea6962",
	maroon = "#ea6962",
	pink = "#d3869b",
	mauve = "#d3869b",
	peach = "#e78a4e",
	yellow = "#d8a657",
	green = "#a9b665",
	teal = "#89b482",
	sky = "#89b482",
	sapphire = "#89b482",
	blue = "#7daea3",
	lavender = "#7daea3",
	text = "#ebdbb2",
	subtext1 = "#d5c4a1",
	subtext0 = "#bdae93",
	overlay2 = "#a89984",
	overlay1 = "#928374",
	overlay0 = "#595959",
	surface2 = "#4d4d4d",
	surface1 = "#404040",
	surface0 = "#292929",
	base = "#1d2021",
	mantle = "#191b1c",
	crust = "#141618",
}

local colorscheme = {
	foreground = mocha.text,
	background = mocha.base,
	cursor_bg = mocha.rosewater,
	cursor_border = mocha.rosewater,
	cursor_fg = mocha.crust,
	selection_bg = mocha.surface2,
	selection_fg = mocha.text,
	ansi = {
		"#0C0C0C", -- black
		"#C50F1F", -- red
		"#13A10E", -- green
		"#C19C00", -- yellow
		"#0037DA", -- blue
		"#881798", -- magenta/purple
		"#3A96DD", -- cyan
		"#CCCCCC", -- white
	},
	brights = {
		"#767676", -- black
		"#E74856", -- red
		"#16C60C", -- green
		"#F9F1A5", -- yellow
		"#3B78FF", -- blue
		"#B4009E", -- magenta/purple
		"#61D6D6", -- cyan
		"#F2F2F2", -- white
	},
	tab_bar = {
		background = "rgba(0, 0, 0, 0.4)",
		active_tab = {
			bg_color = mocha.surface2,
			fg_color = mocha.text,
		},
		inactive_tab = {
			bg_color = mocha.surface0,
			fg_color = mocha.subtext1,
		},
		inactive_tab_hover = {
			bg_color = mocha.surface0,
			fg_color = mocha.text,
		},
		new_tab = {
			bg_color = mocha.base,
			fg_color = mocha.text,
		},
		new_tab_hover = {
			bg_color = mocha.mantle,
			fg_color = mocha.text,
			italic = true,
		},
	},
	visual_bell = mocha.red,
	indexed = {
		[16] = mocha.peach,
		[17] = mocha.rosewater,
	},
	scrollbar_thumb = mocha.surface2,
	split = mocha.overlay0,
	compose_cursor = mocha.flamingo,
}

return colorscheme
