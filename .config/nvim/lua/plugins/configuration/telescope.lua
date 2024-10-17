-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`

if vim.g.vscode ~= nil then
	return
end

local telescope = require("telescope")
telescope.setup({
	extensions = {
		helpgrep = {
			ignore_paths = {
				vim.fn.stdpath("state") .. "/lazy/readme",
			},
		},
		egrepify = {
			AND = false,
		},
		ast_grep = {
			command = {
				"sg",
				"--json=stream",
			}, -- must have --json=stream
			grep_open_files = false, -- search in opened files
			lang = nil, -- string value, specify language for ast-grep `nil` for default
		},
	},
})

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

local telescope_search_layout = {
	sorting_strategy = "ascending",
	layout_strategy = "vertical",
	mappings = { i = { ["<C-u>"] = false, ["<C-d>"] = false } },
	preview_cutoff = 1,
}

vim.keymap.set("n", "<leader>sf", function()
	require("telescope.builtin").find_files({
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		mappings = { i = { ["<C-u>"] = false, ["<C-d>"] = false } },
		previewer = false,
		prompt_position = "top",
	})
end, { desc = "[s]earch [f]iles" })
vim.keymap.set("n", "<leader>sg", function()
	require("telescope").extensions.egrepify.egrepify(telescope_search_layout)
end, { desc = "[s]earch by [g]rep" })
vim.keymap.set("n", "<leader>sa", function()
	require("telescope").extensions.ast_grep.ast_grep(telescope_search_layout)
end, { desc = "[s]earch by [a]st grep" })
vim.keymap.set("n", "<leader>tr", require("telescope.builtin").resume, { desc = "[t]elescope [r]esume" })

vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "[g]it [f]iles" })
-- vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[s]earch [h]elp' })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[s]earch current [w]ord" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[s]earch [d]iagnostics" })

vim.keymap.set("n", "<leader>st", function()
	require("telescope.builtin").tagstack(telescope_search_layout)
end, { desc = "[s]earch [t]agstack" })

vim.keymap.set("n", "to", "<C-t>", { desc = "[t]ag [o]ut" })

-- that fixes nvim-ufo (folding plugin)
vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number")

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")
require("telescope").load_extension("harpoon")
require("telescope").load_extension("dap")
require("telescope").load_extension("helpgrep")
require("telescope").load_extension("ast_grep")
require("telescope").load_extension("egrepify")
require("telescope").load_extension("yaml_schema")
