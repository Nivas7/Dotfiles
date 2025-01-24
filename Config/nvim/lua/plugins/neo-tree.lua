return {
	"nvim-neo-tree/neo-tree.nvim",
	enabled = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		"mrbjarksen/neo-tree-diagnostics.nvim",
		"miversen33/netman.nvim",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	keys = {
		{ "<leader><tab>", ":Neotree toggle float<CR>", silent = true, desc = "Float File Explorer" },
		{ "<leader>ee", ":Neotree toggle left<CR>", silent = true, desc = "Left File Explorer" },
	},
	cmd = { "Neotree" },
	opts = {
		filesystem = {
			filtered_items = {
				visible = true,
				show_hidden_count = true,
				hide_dotfiles = false,
				hide_gitignored = true,
				hide_by_name = {
					".git",
					".DS_Store",
					"thumbs.db",
					".venv",
				},
				never_show = {},
			},
		},
		window = {
			position = "right",
			width = 35,
		},
	},
	config = function()
		local events = require("neo-tree.events")
		vim.cmd([[
      hi NeoTreeCursorLine gui=bold guibg=#333333
    ]])

		local config = {
			sources = {
				"filesystem",
				"buffers",
				"git_status",
				"diagnostics",
				"netman.ui.neo-tree",
				"document_symbols",
			},
			log_level = "trace",
			log_to_file = false,
			open_files_in_last_window = true,
			sort_case_insensitive = true,
			popup_border_style = "rounded",
			default_component_configs = {
				container = {},
				indent = {
					with_markers = true,
					with_arrows = true,
					with_expanders = true,
					padding = 2,
				},
				git_status = {
					symbols = {
						added = "+",
						deleted = "✖",
						modified = "M",
						renamed = "",
						untracked = "",
						ignored = "",
						unstaged = "",
						staged = "",
						conflict = "",
					},
				},
				name = {
					trailing_slash = true,
				},
				created = {
					enabled = false,
				},
			},
			event_handlers = {
				{
					event = events.NEO_TREE_BUFFER_ENTER,
					handler = function()
						vim.cmd("highlight! Cursor blend=100")
					end,
				},
				{
					event = events.NEO_TREE_BUFFER_LEAVE,
					handler = function()
						vim.cmd("highlight! Cursor guibg=#5f87af blend=0")
					end,
				},
			},
			nesting_rules = {},
			window = {
				auto_expand_width = false,
				width = 40,
				mapping_options = {
					noremap = true,
					nowait = true,
				},
				mappings = {
					["Y"] = function(state)
						local node = state.tree:get_node()
						local path = node:get_id()
						vim.fn.setreg("+", path, "c")
					end,
				},
			},
			diagnostics = {
				window = {
					relative = "win",
					position = "bottom",
				},
				refresh = {
					delay = 1000,
					event = "vim_diagnostic_changed",
					max_items = 100,
				},
				components = {
					linenr = function(config, node)
						local lnum = tostring(node.extra.diag_struct.lnum + 1)
						local pad = string.rep(" ", 4 - #lnum)
						return {
							{
								text = pad .. lnum,
								highlight = "LineNr",
							},
							{
								text = "▕ ",
								highlight = "NeoTreeDimText",
							},
						}
					end,
				},
				renderers = {
					file = {
						{ "indent" },
						{ "icon" },
						{ "grouped_path" },
						{ "name", highlight = "NeoTreeFileNameOpened" },
						{ "diagnostic_count", highlight = "NeoTreeDimText", severity = "Error", right_padding = 0 },
						{ "diagnostic_count", highlight = "NeoTreeDimText", severity = "Warn", right_padding = 0 },
						{ "diagnostic_count", highlight = "NeoTreeDimText", severity = "Info", right_padding = 0 },
						{ "diagnostic_count", highlight = "NeoTreeDimText", severity = "Hint", right_padding = 0 },
						{ "clipboard" },
					},
					diagnostic = {
						{ "indent" },
						{ "icon" },
						{ "linenr" },
						{ "name" },
						{ "source" },
					},
				},
			},
			document_symbols = {
				follow_cursor = true,
			},
			buffers = {
				terminals_first = true,
				window = {
					auto_expand_width = false,
					width = 40,
					mapping_options = {
						noremap = true,
						nowait = true,
					},
					mappings = {
						["<esc>"] = "cancel",
						["a"] = { "add", config = { show_path = "relative" } },
						["l"] = "none",
						["z"] = "close_all_nodes",
						["Z"] = "expand_all_nodes",
						["gu"] = "git_unstage_file",
						["ga"] = "git_add_file",
						["gr"] = "git_revert_file",
						["gc"] = "git_commit",
						["gp"] = "git_push",
						["pp"] = "focus_preview",
					},
				},
			},
			filesystem = {
				cwd_target = {
					sidebar = "tab",
					current = "window",
				},
				check_gitignore_in_search = false,
				follow_current_file = { enabled = true },
				group_empty_dirs = false,
				use_libuv_file_watcher = true,
				bind_to_cwd = true,
				find_command = "fd",
				find_args = {
					fd = {
						"--exclude",
						".git",
						"--exclude",
						"node_modules",
					},
				},
				find_by_full_path_words = true,
				window = {
					position = "left",
					popup = {
						position = { col = "100%", row = "2" },
						size = function(state)
							local root_name = vim.fn.fnamemodify(state.path, ":~")
							local root_len = string.len(root_name) + 4
							return {
								width = math.max(root_len, 50),
								height = vim.o.lines - 6,
							}
						end,
					},
					mappings = {
						["/"] = "none",
						["f"] = "fuzzy_sorter",
						["h"] = function(state)
							local node = state.tree:get_node()
							if node.type == "directory" and node:is_expanded() then
								require("neo-tree.sources.filesystem").toggle_directory(state, node)
							else
								require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
							end
						end,
						["l"] = function(state)
							local node = state.tree:get_node()
							if node.type == "directory" then
								if not node:is_expanded() then
									require("neo-tree.sources.filesystem").toggle_directory(state, node)
								elseif node:has_children() then
									require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
								end
							end
						end,
						["K"] = "close_node",
						["J"] = function(state)
							local utils = require("neo-tree.utils")
							local node = state.tree:get_node()
							if utils.is_expandable(node) then
								if not node:is_expanded() then
									require("neo-tree.sources.filesystem").toggle_directory(state, node)
								end
								local children = state.tree:get_nodes(node:get_id())
								if children and #children > 0 then
									local first_child = children[1]
									require("neo-tree.ui.renderer").focus_node(state, first_child:get_id())
								end
							end
						end,
						["<space>"] = function(state)
							local node = state.tree:get_node()
							if require("neo-tree.utils").is_expandable(node) then
								state.commands["toggle_directory"](state)
							else
								state.commands["close_node"](state)
							end
						end,
						["<esc>"] = "cancel",
						["a"] = { "add", config = { show_path = "relative" } },
						["z"] = "close_all_nodes",
						["Z"] = "expand_all_nodes",
						["gu"] = "git_unstage_file",
						["ga"] = "git_add_file",
						["gr"] = "git_revert_file",
						["gc"] = "git_commit",
						["gp"] = "git_push",
						["pp"] = "focus_preview",
					},
				},
			},
		}

		require("neo-tree").setup(config)
	end,
}
