assert(vim.g.vscode ~= nil)

vim.keymap.set({ "n", "v" }, "<leader>sf", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")

-- LSP

vim.keymap.set(
	{ "n", "v" },
	"<leader>db",
	"<cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<CR>"
)
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

--- LSP END

vim.keymap.set({ "n", "v" }, "<leader>f", "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>")

vim.keymap.set({ "n" }, "<leader>e", "<cmd>lua require('vscode').action('workbench.view.explorer')<CR>")

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<C-h>", "<cmd>lua require('vscode').action('workbench.action.focusLeftGroup')<CR>", opts)
-- vim.keymap.set("n", "<C-j>", "<cmd>lua require('vscode').action('workbench.action.focusBelowGroup')<CR>", opts)
-- vim.keymap.set("n", "<C-k>", "<cmd>lua require('vscode').action('workbench.action.focusAboveGroup')<CR>", opts)
vim.keymap.set("n", "<C-l>", "<cmd>lua require('vscode').action('workbench.action.focusRightGroup')<CR>", opts)

vim.keymap.set({ "n" }, "<leader>q", "<cmd>lua require('vscode').action('workbench.action.closeEditorsAndGroup')<CR>")

vim.keymap.set("n", "<leader>|", "<cmd>lua require('vscode').action('workbench.action.splitEditor')<CR>")
-- vim.keymap.set("n", "<leader>\\", "<cmd>lua require('vscode').action('workbench.action.splitEditorDown')<CR>")

vim.keymap.set("n", "<leader>tt", "<cmd>lua require('vscode').action('workbench.action.toggleSidebarVisibility')<CR>")
