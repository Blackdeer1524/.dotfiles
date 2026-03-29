if vim.g.vscode ~= nil then
	return
end

local defaults = require("lsp.defaults")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

local enabled_servers = {
	"basedpyright",
	"bashls",
	"clangd",
	"cssls",
	"docker_compose_language_service",
	"dockerls",
	"eslint",
	"gopls",
	"html",
	"jsonls",
	"lua_ls",
	"marksman",
	"neocmake",
	"tailwindcss",
	"texlab",
	"yamlls",
	-- "bufls",
	-- "asm_lsp",
	-- "spectral",
}

---@type lspconfig.settings.lua_ls
local lua_ls_settings = {
	Lua = {
		workspace = { checkThirdParty = false },
		telemetry = { enable = false },
		completion = {
			callSnippet = "Replace",
		},
		hint = { enable = true },
		format = {
			enable = true,
			defaultConfig = {
				indent_style = "space",
				indent_size = "4",
			},
		},
	},
}

local function current_working_directory()
	return (vim.uv or vim.loop).cwd() or vim.fn.getcwd()
end

local function root_dir_from_markers(markers)
	return function(bufnr, on_dir)
		local path = vim.api.nvim_buf_get_name(bufnr)
		on_dir(vim.fs.root(path, markers))
	end
end

local function root_dir_from_cwd(_, on_dir)
	on_dir(current_working_directory())
end

local function extend_on_attach(config_name, extra)
	local base = vim.lsp.config[config_name] and vim.lsp.config[config_name].on_attach
	return function(client, bufnr)
		if base then
			base(client, bufnr)
		end

		defaults.on_attach(client, bufnr)

		if extra then
			extra(client, bufnr)
		end
	end
end

require("mason").setup({
	ui = {
		border = "rounded",
	},
})

require("mason-lspconfig").setup({
	ensure_installed = enabled_servers,
	automatic_enable = false,
})

require("ufo").setup()

vim.lsp.config("*", {
	capabilities = capabilities,
	on_attach = defaults.on_attach,
})

vim.lsp.config("gopls", {
	cmd = { defaults.MASON_BIN .. "/gopls" },
	settings = {
		gopls = {
			analyses = {
				nilness = true,
				unusedparams = true,
				unusedwrite = true,
				useany = true,
				shadow = true,
			},
			experimentalPostfixCompletions = true,
			gofumpt = true,
			usePlaceholders = true,
			codelenses = {
				gc_details = false,
				generate = true,
				regenerate_cgo = true,
				run_govulncheck = true,
				test = true,
				tidy = true,
				upgrade_dependency = true,
				vendor = true,
			},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		},
	},
})

vim.lsp.config("basedpyright", {
	root_dir = root_dir_from_markers({
		".venv",
		"venv",
		"pyrightconfig.json",
		"Pipfile",
		"pyproject.toml",
		".git",
		"README.md",
	}),
	single_file_support = true,
	on_attach = extend_on_attach("basedpyright", function(client)
		client.server_capabilities.documentFormattingProvider = false
	end),
	settings = {
		basedpyright = {
			autoImportCompletion = true,
			disableLanguageServices = false,
			disableOrganizeImports = false,
			analysis = {
				autoImportCompletions = true,
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				useLibraryCodeForTypes = true,
				typeCheckingMode = "basic",
			},
		},
	},
})

vim.lsp.config("bufls", {
	root_dir = root_dir_from_markers({ "buf.yaml", "buf.gen.yaml", ".git", "README.md" }),
	filetypes = { "proto", "ev" },
})

vim.lsp.config("html", {
	filetypes = { "html", "templ", "template" },
	on_attach = extend_on_attach("html", function(client)
		client.server_capabilities.documentRangeFormattingProvider = false
		client.server_capabilities.documentFormattingProvider = false
	end),
	settings = {
		html = {
			hover = {
				documentation = true,
				references = true,
			},
		},
	},
})

vim.lsp.config("clangd", {
	root_markers = {
		"Makefile",
		"configure.ac",
		"configure.in",
		"config.h.in",
		"meson.build",
		"meson_options.txt",
		"build.ninja",
		"compile_commands.json",
		"compile_flags.txt",
		".git",
	},
	capabilities = {
		offsetEncoding = { "utf-8" },
	},
	on_attach = extend_on_attach("clangd", function(_, bufnr)
		vim.keymap.set(
			"n",
			"<leader>ch",
			require("clangd_extensions.switch_source_header").switch_source_header,
			{ desc = "[c]langd switch source [h]eader", buffer = bufnr }
		)
	end),
	cmd = {
		defaults.MASON_BIN .. "/clangd",
		"--background-index",
		string.format("-j=%d", #(vim.uv or vim.loop).cpu_info()),
		"--header-insertion=iwyu",
		"--all-scopes-completion",
		"--completion-style=detailed",
		"--pch-storage=memory",
	},
})

vim.lsp.config("lua_ls", {
	settings = lua_ls_settings,
})

local yaml_config = require("yaml-companion").setup({
	lspconfig = {
		on_attach = defaults.on_attach,
		capabilities = capabilities,
	},
})
vim.lsp.config("yamlls", yaml_config)

vim.lsp.config("jsonls", {
	root_dir = root_dir_from_cwd,
	settings = {
		json = {
			schemas = require("schemastore").json.schemas({
				extra = {},
			}),
			validate = { enable = true },
		},
	},
})

vim.lsp.config("spectral", {
	root_dir = root_dir_from_cwd,
})

vim.lsp.config("eslint", {
	on_attach = extend_on_attach("eslint"),
	settings = {
		format = { enable = true },
	},
})

vim.lsp.config("tailwindcss", {
	on_attach = defaults.on_attach,
	init_options = {
		userLanguages = {
			eelixir = "html-eex",
			eruby = "erb",
			templ = "html",
		},
	},
	settings = {
		tailwindCSS = {
			lint = {
				cssConflict = "warning",
				invalidApply = "error",
				invalidConfigPath = "error",
				invalidScreen = "error",
				invalidTailwindDirective = "error",
				invalidVariant = "error",
				recommendedVariantOrder = "warning",
			},
			validate = true,
		},
	},
})

-- vim.lsp.config("asm_lsp", {
-- 	root_dir = root_dir_from_markers({ ".asm-lsp.toml", ".git", "README.md" }),
-- })

for _, server in ipairs(enabled_servers) do
	vim.lsp.enable(server)
end
