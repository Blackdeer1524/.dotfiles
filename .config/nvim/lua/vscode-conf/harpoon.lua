vim.keymap.set("n", "<leader>ah", "<cmd>lua require('vscode').action('vscode-harpoon.addEditor')<CR>") -- desc = "[a]dd to [h]arpoon",
vim.keymap.set("n", "<leader>sh", "<cmd>lua require('vscode').action('vscode-harpoon.editEditors')<CR>") -- desc = "[s]how [h]arpoon menu",
vim.keymap.set("n", "<leader>j",  "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor1')<CR>") -- desc = "Harpoon first",
vim.keymap.set("n", "<leader>k",  "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor2')<CR>") -- desc = "Harpoon second",
vim.keymap.set("n", "<leader>l",  "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor3')<CR>") -- desc = "Harpoon third",
vim.keymap.set("n", "<leader>;",  "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor4')<CR>") -- desc = "Harpoon fourth",
