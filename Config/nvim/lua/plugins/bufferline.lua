return {
	"akinsho/bufferline.nvim",
	enabled = true,
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
		options = {
			debug = { logging = true },
			indicator = { icon = "▍", style = "underline" },
			sort_by = "insert_after_current",
			move_wraps_at_ends = true,
			right_mouse_command = "vert sbuffer %d",
			show_close_icon = false,
			show_buffer_close_icons = false,
			hover = { enabled = true, reveal = { "close" } },
			offsets = {
				{
					filetype = "neo-tree",
					text = " File Explorer",
					highlight = "Directory",
					separator = false,
				},
			},
		},
	},
}
