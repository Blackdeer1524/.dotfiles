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
nmap("gp", "<cmd>lua require('vscode').action('editor.action.peekDefinition')<CR>", "[G]oto [D]efinition")

nmap("gr", "<cmd>lua require('vscode').action('editor.action.goToReferences')<CR>", "[G]oto [R]eferences")
nmap("gI", "<cmd>lua require('vscode').action('editor.action.goToImplementation')<CR>", "[G]oto [I]mplementation")

nmap("<leader>oc", "<cmd>lua require('vscode').action('references-view.showOutgoingCalls')<CR>", "[o]utgoing [c]alls")
nmap("<leader>ic", "<cmd>lua require('vscode').action('references-view.showIncomingCalls')<CR>", "[i]ncoming [c]alls")

nmap("<leader>D", "<cmd>lua require('vscode').action('editor.action.goToTypeDefinition')<CR>", "Type [D]efinition")

nmap("<leader>K", vim.lsp.buf.signature_help, "Signature Documentation")

nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
nmap("<leader>ws", vim.lsp.buf.workspace_symbol, "[W]orkspace [A]dd Folder")
nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
nmap(
	"<leader>cl",
	"<cmd>lua require('vscode').action('codelens.showLensesInCurrentLine')<CR>",
	"[W]orkspace [R]emove Folder"
)
