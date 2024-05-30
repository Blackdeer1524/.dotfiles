local M = {
	{
		-- terminal emulator
		"akinsho/toggleterm.nvim",
		version = "*",
		enabled = false,
		opts = {
			open_mapping = [[<leader>tt]],
			start_in_insert = true,
			insert_mappings = false, -- whether or not the open mapping applies in insert mode
			terminal_mappings = false, -- whether or not the open mapping applies in the opened terminals
		},
	},
	{
		-- floating notifications
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				stages = "static",
				timeout = 2000,
			})
			local banned_messages = { "No information available" }
			vim.notify = function(msg, ...)
				for _, banned in ipairs(banned_messages) do
					if msg == banned then
						return
					end
				end
				return require("notify")(msg, ...)
			end
		end,
		lazy = false,
	},
	{
		-- buffers line
		"romgrk/barbar.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			-- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
			animation = false,
			-- insert_at_start = true,
			-- …etc.
		},
		version = "^1.0.0", -- optional: only update when a new 1.x version is released
		enabled = false,
	},
	{
		"mbbill/undotree",
	},
	{
		"stevearc/oil.nvim",
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			buf_options = {
				buflisted = true,
				bufhidden = "hide",
			},
			keymaps = {
				["<C-s>"] = false,
				["<C-|>"] = "actions.select_vsplit",

				["<C-h>"] = false,
				["<C-\\>"] = "actions.select_split",

				["<C-l>"] = false,
				["<C-r>"] = "actions.refresh",
			},
		},
	},
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			local web_devicons_ok, web_devicons = pcall(require, "nvim-web-devicons")
			if not web_devicons_ok then
				return
			end

			local icons_override = {}
			for _, v in pairs({ "mp3", "wav", "aac", "flac", "m4a", "wma", "ogg", "opus", "aiff", "au" }) do
				icons_override[v] = {
					icon = "",
					name = v,
					color = "#672168",
				}
			end
			icons_override["tmpl"] = {
				icon = "󰮲",
				name = "Template",
				color = "#519ABA",
			}
			icons_override["pyw"] = {
				icon = "󰌠",
				name = "PythonNoConsole",
			}
			icons_override["apkg"] = {
				icon = "󰘸",
				name = "AnkiPackage",
			}
			icons_override["proto"] = {
				icon = "󱁜",
				name = "protobufs",
			}
			icons_override["go"] = {
				icon = "󰟓",
				name = "Go",
				color = "#519ABA",
			}
			icons_override["dockerfile"] = {
				icon = "󰡨",
				name = "Dockerfile",
				conor = "#0db7ed",
			}

			web_devicons.setup({
				-- globally enable different highlight colors per icon (default to true)
				-- if set to false all icons will have the default icon's color
				color_icons = true,
				-- globally enable default icons (default to false)
				-- will get overriden by `get_icons` option
				-- globally enable "strict" selection of icons - icon will be looked up in
				-- globally enable "strict" selection of icons - icon will be looked up in
				-- globally enable "strict" selection of icons - icon will be looked up in
				default = true,
				-- globally enable "strict" selection of icons - icon will be looked up in
				-- different tables, first by filename, and if not found by extension; this
				-- prevents cases when file doesn't have any extension but still gets some icon
				-- because its name happened to match some extension (default to false)
				strict = true,
				-- same as `override` but specifically for overrides by filename
				-- takes effect when `strict` is true
				override = {
					["Makefile"] = {
						icon = "",
						name = "Makefile",
						color = "#5B5B5B",
					},
				},
				override_by_filename = {
					["go.mod"] = {
						icon = "󰟓",
						color = "#D30000",
						name = "go.mod",
					},
					["go.sum"] = {
						icon = "󰟓",
						color = "#D30000",
						name = "go.mod",
					},
					-- [".gitignore"] = {
					--     icon = "",
					--     name = "Gitignore"
					-- }
				},
				-- override = material_icon.get_icons(),
				override_by_extension = icons_override,
			})
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
				view = {
					preserve_window_proportions = false,
					relativenumber = true,
				},
				actions = {
					open_file = {
						resize_window = false,
					},
				},
				renderer = {
					indent_markers = {
						enable = true,
					},
				},
				update_focused_file = {
					enable = true,
				},
				filters = {
					dotfiles = false,
				},
				sync_root_with_cwd = true,
			})

			vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFile<cr>", { desc = "Open nvim tree tree" })
		end,
	},
	{
		-- search and replace tool
		"nvim-pack/nvim-spectre",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {
			attach_navic = false,
			show_navic = false,
			include_buftypes = { "", "acwrite" }, -- acwrite buftype is used in oil.nvim
		},
	},
}

return M
