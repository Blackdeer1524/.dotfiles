-- vim.keymap.set('n', "<leader>e", "<cmd>Neotree position=left<cr>", { desc = "Open neotree tree" })
-- vim.keymap.set('n', "<leader>e", "<cmd>CHADopen --always-focus<cr>", { desc = "Open nvim tree tree" })

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.keymap.set("n", "<leader>f", require("conform").format, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "UndoTree toggle" })

-- vim.keymap.set('n', '<A-c>', '<Cmd>BufferClose<CR>')

-- nvim-spectre
vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").open()<CR>', {
	desc = "Open Spectre",
})

vim.keymap.set("n", "[c", function()
	require("treesitter-context").go_to_context()
end, { silent = true, desc = "go to [c]ontext" })
