local M = {
	{
		"ThePrimeagen/harpoon",
		dependencies = { "nvim-lua/plenary.nvim" },
		enabled = vim.g.vscode == nil,
		branch = "harpoon2",
		opts = {},
		keys = {
			{
				"<leader>ah",
				function()
					require("harpoon"):list():append()
				end,
				desc = "[a]dd to [h]arpoon",
			},
			{
				"<leader>sh",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "[s]how [h]arpoon menu",
			},
			{
				"<leader>j",
				function()
					require("harpoon"):list():select(1)
				end,
				desc = "Harpoon first",
			},
			{
				"<leader>k",
				function()
					require("harpoon"):list():select(2)
				end,
				desc = "Harpoon second",
			},
			{
				"<leader>l",
				function()
					require("harpoon"):list():select(3)
				end,
				desc = "Harpoon third",
			},
			{
				"<leader>;",
				function()
					require("harpoon"):list():select(4)
				end,
				desc = "Harpoon fourth",
			},
		},
	},
	{
		"christoomey/vim-tmux-navigator",
		enabled = vim.g.vscode == nil,
		config = function()
			vim.g.tmux_navigator_save_on_switch = 2
			vim.g.tmux_navigator_no_wrap = 1
		end,
	},
	-- Fuzzy Finder Algorithm which requires local dependencies to be built.
	-- Only load if `make` is available. Make sure you have the system
	-- requirements installed.
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		enabled = vim.g.vscode == nil,
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		enabled = vim.g.vscode == nil,
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"catgoose/telescope-helpgrep.nvim",
			"Marskey/telescope-sg",
			"fdschmidt93/telescope-egrepify.nvim",
		},
	},
}
return M
