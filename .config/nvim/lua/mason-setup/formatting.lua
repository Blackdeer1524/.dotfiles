require("mason-null-ls").setup({
	ensure_installed = {
		"goimports",
		"cmakelang",
		"black",
		"gofumpt",
		"goimports-reviser",
		"golines",
		"latexindent",
		"markdown-toc",
		"markdownlint",
		"mdformat",
		"prettier",
	},
	automatic_installation = true,
})
