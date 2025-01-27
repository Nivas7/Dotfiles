-- NOTE: Utility plugins
return {
	-- Utilities
	{
		"nvim-lua/plenary.nvim",
	},
	-- Schemas
	{ "b0o/schemastore.nvim" },
	-- Buffer Delete
	{
		"moll/vim-bbye",
		cmd = { "Bdelete", "Bwipeout" },
	},
	-- Better QuickFixList
	{
		"stevearc/quicker.nvim",
		event = "VeryLazy",
		opts = {},
	},
}
