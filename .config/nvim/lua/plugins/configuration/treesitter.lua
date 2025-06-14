-- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
-- See `:help nvim-treesitter`
---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
	-- Add languages to be installed here that you want installed for treesitter
	ensure_installed = {
		"dockerfile",
		"java",
		"json5",
		"scala",
		"yaml",
		"c",
		"sql",
		"cpp",
		"go",
		"gomod",
		"gosum",
		"lua",
		"python",
		"rust",
		"html",
		"css",
		"tsx",
		"javascript",
		"jsdoc",
		"typescript",
		"vimdoc",
		"proto",
		"markdown",
		"markdown_inline",
		"latex",
		"regex",
		"dap_repl",
		"vim",
		"make",
		"doxygen",
		"cmake",
	},
	auto_install = false,
	highlight = {
		enable = vim.g.vscode == nil,
		disable = function(lang, bufnr)
			if lang == "go" then
				return vim.api.nvim_buf_line_count(bufnr) > 3000
			end
			return vim.api.nvim_buf_line_count(bufnr) > 5000
		end,
	},
	indent = { enable = false, disable = { "python" } },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<c-space>",
			node_incremental = "<c-space>",
			scope_incremental = "<c-s>",
			node_decremental = "<M-space>",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>sn"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>sb"] = "@parameter.inner",
			},
		},
	},
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.gotmpl = {
	install_info = {
		url = "https://github.com/ngalaiko/tree-sitter-go-template",
		files = { "src/parser.c" },
	},
	filetype = "gotmpl",
	used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "yaml" },
}
vim.treesitter.language.register("html", "template")
