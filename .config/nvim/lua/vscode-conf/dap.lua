vim.keymap.set("n", "<leader>db", "<cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<CR>")
vim.keymap.set("n", "<leader>dB", "<cmd>lua require('vscode').action('editor.debug.action.conditionalBreakpoint')<cr>")
vim.keymap.set("n", "<leader>dl", "<cmd>lua require('vscode').action('editor.debug.action.addLogPoint')<cr>")
vim.keymap.set("n", "<leader>dr", "<cmd>lua require('vscode').action('workbench.action.debug.restart')<cr>")
vim.keymap.set("n", "<leader>dh", "<cmd>lua require('vscode').action('editor.debug.action.showDebugHover')<cr>")
vim.keymap.set("n", "<leader>dK", "<cmd>lua require('vscode').action('workbench.action.debug.stop')<cr>")
vim.keymap.set("n", "<leader>dc", "<cmd>lua require('vscode').action('editor.debug.action.runToCursor')<cr>")
vim.keymap.set(
	"n",
	"<leader>dC",
	"<cmd>lua require('vscode').action('workbench.debug.viewlet.action.removeAllBreakpoints')<cr>"
)
vim.keymap.set("n", "<leader>dd", "<cmd>lua require('vscode').action('workbench.action.debug.callStackUp')<cr>")
vim.keymap.set("n", "<leader>du", "<cmd>lua require('vscode').action('workbench.action.debug.callStackDown')<cr>")
vim.keymap.set("n", "<leader>ds", "<cmd>lua require('vscode').action('debug.jumpToCursor')<cr>")
vim.keymap.set("n", "<leader>df", "<cmd>lua require('vscode').action('workbench.action.debug.callStackTop')<cr>")
vim.keymap.set("n", "<leader>de", "<cmd>lua require('vscode').action('workbench.debug.action.focusRepl')<cr>")

vim.keymap.set("n", "<leader>db", "<cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<CR>")
vim.keymap.set("n", "<leader>dB", "<cmd>lua require('vscode').action('editor.debug.action.conditionalBreakpoint')<cr>")
vim.keymap.set("n", "<leader>dl", "<cmd>lua require('vscode').action('editor.debug.action.addLogPoint')<cr>")
vim.keymap.set("n", "<leader>dr", "<cmd>lua require('vscode').action('workbench.action.debug.restart')<cr>")
vim.keymap.set("n", "<leader>dh", "<cmd>lua require('vscode').action('editor.debug.action.showDebugHover')<cr>")
vim.keymap.set("n", "<leader>dK", "<cmd>lua require('vscode').action('workbench.action.debug.stop')<cr>")
vim.keymap.set("n", "<leader>dc", "<cmd>lua require('vscode').action('editor.debug.action.runToCursor')<cr>")
