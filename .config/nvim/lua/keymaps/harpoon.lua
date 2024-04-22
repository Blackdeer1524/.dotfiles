local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<leader>ah", function() harpoon:list():append() end, { desc = "[a]dd to [h]arpoon" })
vim.keymap.set("n", "<leader>sh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "[s]how [h]arpoon menu" })

vim.keymap.set("n", "<leader>j", function() harpoon:list():select(1) end, { desc = "Harpoon first" })
vim.keymap.set("n", "<leader>k", function() harpoon:list():select(2) end, { desc = "Harpoon second" })
vim.keymap.set("n", "<leader>l", function() harpoon:list():select(3) end, { desc = "Harpoon third" })
vim.keymap.set("n", "<leader>;", function() harpoon:list():select(4) end, { desc = "Harpoon fourth" })