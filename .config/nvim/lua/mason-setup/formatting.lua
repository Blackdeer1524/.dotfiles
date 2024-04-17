require('mason-null-ls').setup({
    ensure_installed = {
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
    automatic_installation = true
})
