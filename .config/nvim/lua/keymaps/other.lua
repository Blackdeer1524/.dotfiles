-- vim.keymap.set('n', "<leader>e", "<cmd>Neotree position=left<cr>", { desc = "Open neotree tree" })
-- vim.keymap.set('n', "<leader>e", "<cmd>CHADopen --always-focus<cr>", { desc = "Open nvim tree tree" })

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.keymap.set("n", "[c", function()
	require("treesitter-context").go_to_context()
end, { silent = true, desc = "go to [c]ontext" })
