vim.keymap.set({ "n", "v" }, "<leader>sf", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")
vim.keymap.set({ "n" }, "<leader>e", "<cmd>lua require('vscode').action('workbench.view.explorer')<CR>")

vim.keymap.set({ "n", "v" }, "<leader>f", "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>")

local opts = { noremap = true, silent = true }

-- vim.keymap.set("n", "<C-h>", "<cmd>lua require('vscode').action('workbench.action.focusLeftGroup')<CR>", opts)
-- vim.keymap.set("n", "<C-j>", "<cmd>lua require('vscode').action('workbench.action.focusBelowGroup')<CR>", opts)
-- vim.keymap.set("n", "<C-k>", "<cmd>lua require('vscode').action('workbench.action.focusAboveGroup')<CR>", opts)
-- vim.keymap.set("n", "<C-l>", "<cmd>lua require('vscode').action('workbench.action.focusRightGroup')<CR>", opts)

vim.keymap.set({ "n" }, "<A-q>", "<cmd>lua require('vscode').action('workbench.action.closeEditorsAndGroup')<CR>")
vim.keymap.set({ "n" }, "<leader>q", "<cmd>lua require('vscode').action('editor.action.showHover')<CR>")

vim.keymap.set("n", "<leader>|", "<cmd>lua require('vscode').action('workbench.action.splitEditor')<CR>")
-- vim.keymap.set("n", "<leader>\\", "<cmd>lua require('vscode').action('workbench.action.splitEditorDown')<CR>")

vim.keymap.set("n", "<leader>tt", "<cmd>lua require('vscode').action('workbench.action.toggleSidebarVisibility')<CR>")

vim.keymap.set(
	"n",
	"<leader>sg",
	"<cmd>lua require('vscode').action('search.action.openNewEditor')<CR>",
	{ desc = "[s]earch by [g]rep" }
)

vim.keymap.set(
	"n",
	"<leader>tr",
	"<cmd>lua require('vscode').action('search.action.openEditor')<CR>",
	{ desc = "[s]earch by [g]rep" }
)

vim.keymap.set(
	"n",
	"<leader>so",
	"<cmd>lua require('vscode').action('workbench.action.toggleAuxiliaryBar')<CR>",
	{ desc = "[s]ymbol [o]utlin" }
)

local function moveCursor(direction)
	if vim.fn.reg_recording() == "" and vim.fn.reg_executing() == "" then
		return ("g" .. direction)
	else
		return direction
	end
end

vim.keymap.set("n", "k", function()
	return moveCursor("k")
end, { expr = true, remap = true })
vim.keymap.set("n", "j", function()
	return moveCursor("j")
end, { expr = true, remap = true })

vim.cmd([[
nnoremap zM :call VSCodeNotify('editor.foldAll')<CR>
nnoremap zR :call VSCodeNotify('editor.unfoldAll')<CR>
nnoremap zc :call VSCodeNotify('editor.fold')<CR>
nnoremap zC :call VSCodeNotify('editor.foldRecursively')<CR>
nnoremap zo :call VSCodeNotify('editor.unfold')<CR>
nnoremap zO :call VSCodeNotify('editor.unfoldRecursively')<CR>
nnoremap za :call VSCodeNotify('editor.toggleFold')<CR>
]])

vim.keymap.set({ "n", "v" }, "[d", "<cmd>lua require('vscode').action('editor.action.marker.prev')<CR>")
vim.keymap.set({ "n", "v" }, "]d", "<cmd>lua require('vscode').action('editor.action.marker.next')<CR>")
