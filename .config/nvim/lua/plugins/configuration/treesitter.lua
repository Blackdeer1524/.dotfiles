-- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
-- See `:help nvim-treesitter`
local parsers = {
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
	"gotmpl",
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
}

local function should_start_treesitter(bufnr)
	if vim.g.vscode ~= nil then
		return false
	end

	local filetype = vim.bo[bufnr].filetype
	local line_count = vim.api.nvim_buf_line_count(bufnr)
	if filetype == "go" then
		return line_count <= 3000
	end

	return line_count <= 5000
end

local function configure_textobjects()
	require("nvim-treesitter-textobjects").setup({
		select = {
			lookahead = true,
		},
		move = {
			set_jumps = true,
		},
	})

	local select = require("nvim-treesitter-textobjects.select")
	local move = require("nvim-treesitter-textobjects.move")
	local swap = require("nvim-treesitter-textobjects.swap")

	local select_maps = {
		aa = "@parameter.outer",
		ia = "@parameter.inner",
		af = "@function.outer",
		["if"] = "@function.inner",
		ac = "@class.outer",
		ic = "@class.inner",
	}
	for lhs, query in pairs(select_maps) do
		vim.keymap.set({ "x", "o" }, lhs, function()
			select.select_textobject(query, "textobjects")
		end, { desc = "select " .. query })
	end

	local move_maps = {
		["]m"] = function()
			move.goto_next_start("@function.outer", "textobjects")
		end,
		["]]"] = function()
			move.goto_next_start("@class.outer", "textobjects")
		end,
		["]M"] = function()
			move.goto_next_end("@function.outer", "textobjects")
		end,
		["]["] = function()
			move.goto_next_end("@class.outer", "textobjects")
		end,
		["[m"] = function()
			move.goto_previous_start("@function.outer", "textobjects")
		end,
		["[["] = function()
			move.goto_previous_start("@class.outer", "textobjects")
		end,
		["[M"] = function()
			move.goto_previous_end("@function.outer", "textobjects")
		end,
		["[]"] = function()
			move.goto_previous_end("@class.outer", "textobjects")
		end,
	}
	for lhs, rhs in pairs(move_maps) do
		vim.keymap.set({ "n", "x", "o" }, lhs, rhs, { desc = "move with treesitter textobjects" })
	end

	vim.keymap.set("n", "<leader>sn", function()
		swap.swap_next("@parameter.inner")
	end, { desc = "swap next parameter" })
	vim.keymap.set("n", "<leader>sb", function()
		swap.swap_previous("@parameter.inner")
	end, { desc = "swap previous parameter" })
end

local function configure_incremental_selection()
	local ok, ts_modules = pcall(require, "treesitter-modules")
	if not ok then
		return
	end

	ts_modules.setup({
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = false,
				node_incremental = false,
				scope_incremental = false,
				node_decremental = false,
			},
		},
	})

	vim.keymap.set("n", "<C-Space>", ts_modules.init_selection, { desc = "treesitter init selection" })
	vim.keymap.set("x", "<C-Space>", ts_modules.node_incremental, { desc = "treesitter expand selection" })
	vim.keymap.set("x", "<A-Space>", ts_modules.node_decremental, { desc = "treesitter shrink selection" })
end

require("nvim-treesitter").setup({})
vim.treesitter.language.register("gotmpl", { "gohtmltmpl", "gotexttmpl", "gotmpl" })
vim.treesitter.language.register("html", { "template" })

local highlight_group = vim.api.nvim_create_augroup("TreesitterHighlighting", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = highlight_group,
	pattern = "*",
	callback = function(args)
		if not should_start_treesitter(args.buf) then
			return
		end

		pcall(vim.treesitter.start, args.buf)
	end,
})

configure_textobjects()
configure_incremental_selection()
if #vim.api.nvim_list_uis() > 0 then
	vim.schedule(function()
		require("nvim-treesitter").install(parsers)
	end)
end
