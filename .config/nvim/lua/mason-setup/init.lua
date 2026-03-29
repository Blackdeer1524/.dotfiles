if vim.g.vscode ~= nil then
	return
end

require("mason-setup.lsp")
require("mason-setup.debug")
