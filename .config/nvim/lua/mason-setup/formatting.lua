require("mason-null-ls").setup({
	ensure_installed = {
		"goimports",
		"cmakelang",
		"black",
		"isort",
		"yamlfmt",
		"stylua",
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
