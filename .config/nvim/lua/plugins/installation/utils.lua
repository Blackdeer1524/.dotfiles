local M = {
	{
		-- autosave events
		"Pocco81/auto-save.nvim",
		config = function()
			require("auto-save").setup({
				trigger_events = { "InsertLeave", "BufLeave" },
				condition = function(buf)
					local fn = vim.fn
					local utils = require("auto-save.utils.data")

					local status, buf_name = pcall(vim.api.nvim_buf_get_name, buf)
					if not status then
						return false
					end

					if string.find(buf_name, "harpoon") or string.find(buf_name, "Overseer") then
						return false
					end
					-- vim.notify(buf_name)

					local oil_protocol = string.sub(buf_name, 1, 6)
					if
						fn.getbufvar(buf, "&modifiable") == 1
						and utils.not_in(fn.getbufvar(buf, "&filetype"), {})
						and oil_protocol ~= "oil://"
					then
						return true -- met condition(s), can save
					end
					return false -- can't save
				end,
			})
		end,
	},
	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		branch = "v0.6", --recommended as each new version will have breaking changes
		opts = {
			--Config goes here
		},
	},
	{
		"abecodes/tabout.nvim",
		lazy = false,
		config = function()
			require("tabout").setup({
				tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
				backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
				act_as_tab = true, -- shift content if tab out is not possible
				act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
				default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
				default_shift_tab = "<C-d>", -- reverse shift default action,
				enable_backwards = true, -- well ...
				completion = false, -- if the tabkey is used in a completion pum
				tabouts = {
					{ open = "'", close = "'" },
					{ open = '"', close = '"' },
					{ open = "`", close = "`" },
					{ open = "(", close = ")" },
					{ open = "[", close = "]" },
					{ open = "{", close = "}" },
				},
				ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
				exclude = {}, -- tabout will ignore these filetypes
			})
		end,
		dependencies = { -- These are optional
			"nvim-treesitter/nvim-treesitter",
			"L3MON4D3/LuaSnip",
			"hrsh7th/nvim-cmp",
		},
		opt = true, -- Set this to true if the plugin is optional
		event = "InsertCharPre", -- Set the event to 'InsertCharPre' for better compatibility
		priority = 1000,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	-- Useful plugin to show you pending keybinds.
	{ "folke/which-key.nvim", opts = {} },
	-- quick test suits
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"dfendr/clipboard-image.nvim",
		opts = {},
	},
}

return M
