return {
	"2nthony/vitesse.nvim",
	dependencies = {
		"tjdevries/colorbuddy.nvim",
	},
	enabled = false,
	lazy = false,
	event = "VeryLazy",
	priority = 1000,
	opts = {},
	config = function()
		vim.cmd("colorscheme vitesse")
	end,
}
