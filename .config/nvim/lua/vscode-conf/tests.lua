vim.keymap.set({ "n" }, "<leader>nda", function()
	require("vscode").action("testing.debugAll")
end)

vim.keymap.set({ "n" }, "<leader>ndl", function()
	require("vscode").action("testing.debugLastRun")
end)

vim.keymap.set({ "n" }, "<leader>ndc", function()
	require("vscode").action("testing.debugAtCursor")
end)

vim.keymap.set({ "n" }, "<leader>ndf", function()
	require("vscode").action("testing.debugCurrentFile")
end)

vim.keymap.set({ "n" }, "<leader>nrl", function()
	require("vscode").action("testing.reRunLastRun")
end)

vim.keymap.set({ "n" }, "<leader>nra", function()
	require("vscode").action("testing.runAll")
end)

vim.keymap.set({ "n" }, "<leader>nrc", function()
	require("vscode").action("testing.runAtCursor")
end)

vim.keymap.set({ "n" }, "<leader>nrf", function()
	require("vscode").action("testing.runCurrentFile")
end)

vim.keymap.set({ "n" }, "<leader>no", function()
	require("vscode").action("testing.showMostRecentOutput")
end)
