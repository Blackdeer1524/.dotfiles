-- Setup mason so it can manage external tooling
require("mason").setup({
	ui = {
		border = "rounded",
	},
	automatic_installation = true,
	ensure_installled = {
		-- C++
		"cmakelang",
		-- "cpplint",
		-- protobufs
		"buf", -- formatter, linter
		-- "protolint",   -- linter
		-- markdonw
		"markdownlint",
		-- Python
		"mypy",
		-- Go
		-- "revive",
		"golangci-lint",
		-- SQL
		"sqlfluff",
	},
})

require("mason-setup.lsp")
require("mason-setup.debug")
require("mason-setup.formatting")
