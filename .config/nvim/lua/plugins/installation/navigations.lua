local M = {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"christoomey/vim-tmux-navigator",
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
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
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
