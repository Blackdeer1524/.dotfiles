local M = {
	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
		lazy = false,
		priority = 1000,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			separator = "─",
			max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
			multiline_threshold = 1, -- Maximum number of lines to show for a single context
		},
	},
	{
		"andersevenrud/nvim_context_vt",
		opts = {
			disable_virtual_lines = true,
			min_rows = 10,
		},
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		dependencies = {
			{
				-- "gc" to comment visual regions/lines
				"numToStr/Comment.nvim",
				config = function()
					require("ts_context_commentstring").setup({ enable_autocmd = false })
					require("Comment").setup({
						pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
					})
				end,
			},
		},
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			-- 	filetypes = {
			-- 		"html",
			-- 		"javascript",
			-- 		"typescript",
			-- 		"javascriptreact",
			-- 		"typescriptreact",
			-- 		"svelte",
			-- 		"vue",
			-- 		"tsx",
			-- 		"jsx",
			-- 		"rescript",
			-- 		"xml",
			-- 		"php",
			-- 		"markdown",
			-- 		"astro",
			-- 		"glimmer",
			-- 		"handlebars",
			-- 		"hbs",
			-- 		"gotmpl",
			-- 		"template",
			-- 		"tmpl",
			-- 	},
			---@diagnostic disable-next-line: missing-fields
			require("nvim-ts-autotag").setup({
				opts = {
					enable = true,
					enable_rename = true,
					enable_close = true,
					enable_close_on_slash = true,
				},
				-- Also override individual filetype configs, these take priority.
				-- Empty by default, useful if one of the "opts" global settings
				-- doesn't work well in a specific filetype
				per_filetype = {
					["html"] = {
						-- enable_close = false,
					},
				},
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		-- Vim plugin for automatically highlighting other uses of the word
		-- under the cursor using either LSP, Tree-sitter, or regex matching.
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				delay = 300,
				large_file_cutoff = 30000,
			})
		end,
	},
}

return M
