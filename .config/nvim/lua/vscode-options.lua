assert(vim.g.vscode ~= nil)

vim.keymap.set({ "n", "v" }, "<leader>sf", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")

-- LSP

vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>")

local nmap = function(keys, func, desc)
	if desc then
		desc = "LSP: " .. desc
	end
	vim.keymap.set("n", keys, func, { desc = desc })
end

nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
nmap("<leader>cl", vim.lsp.codelens.run, "select [C]ode[L]ens")

nmap("gd", "<cmd>lua require('vscode').action('editor.action.revealDefinition')<CR>", "[G]oto [D]efinition")
nmap("gP", "<cmd>lua require('vscode').action('editor.action.peekDefinition')<CR>", "[G]oto [D]efinition")

nmap("gr", "<cmd>lua require('vscode').action('editor.action.goToReferences')<CR>", "[G]oto [R]eferences")
nmap("gI", "<cmd>lua require('vscode').action('editor.action.goToImplementation')<CR>", "[G]oto [I]mplementation")

nmap("<leader>oc", "<cmd>lua require('vscode').action('references-view.showOutgoingCalls')<CR>", "[o]utgoing [c]alls")
nmap("<leader>ic", "<cmd>lua require('vscode').action('references-view.showIncomingCalls')<CR>", "[i]ncoming [c]alls")

nmap("<leader>D", "<cmd>lua require('vscode').action('editor.action.goToTypeDefinition')<CR>", "Type [D]efinition")

nmap("<leader>K", vim.lsp.buf.signature_help, "Signature Documentation")

nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
nmap(
	"<leader>cl",
	"<cmd>lua require('vscode').action('codelens.showLensesInCurrentLine')<CR>",
	"[W]orkspace [R]emove Folder"
)

--- LSP END

vim.keymap.set({ "n", "v" }, "<leader>f", "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>")

vim.keymap.set({ "n" }, "<leader>e", "<cmd>lua require('vscode').action('workbench.view.explorer')<CR>")

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
	"<cmd>lua require('vscode').action('periscope.search')<CR>",
	{ desc = "[s]earch by [g]rep" }
)

-- DAP

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
vim.keymap.set("n", "<leader>dd", "<cmd>lua require('vscode').action('workbench.action.debug.callStackDown')<cr>")
vim.keymap.set("n", "<leader>du", "<cmd>lua require('vscode').action('workbench.action.debug.callStackUp')<cr>")
vim.keymap.set("n", "<leader>ds", "<cmd>lua require('vscode').action('debug.jumpToCursor')<cr>")
vim.keymap.set("n", "<leader>df", "<cmd>lua require('vscode').action('workbench.action.debug.callStackTop')<cr>")
vim.keymap.set("n", "<leader>de", "<cmd>lua require('vscode').action('workbench.debug.action.focusRepl')<cr>")

--

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
