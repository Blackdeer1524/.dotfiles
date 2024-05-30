local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

require("ufo").setup()

local on_attach = require("lsp.defaults").on_attach

local function init_metals()
	local metals_config = require("metals").bare_config()
	metals_config.settings = {
		showImplicitArguments = true,
		excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
	}
	metals_config.init_options.statusBarProvider = "on"

	-- Example if you are using cmp how to make sure the correct capabilities for snippets are set
	metals_config.capabilities = capabilities

	metals_config.on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		require("metals").setup_dap()
	end

	local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "scala", "sbt" },
		callback = function()
			require("metals").initialize_or_attach(metals_config)
		end,
		group = nvim_metals_group,
	})
end

init_metals()

local lsputil = require("lspconfig/util")

require("lspconfig.configs").pb = {
	default_config = {
		cmd = { "pb", "lsp" },
		filetypes = { "proto", "ev" },
		root_dir = lsputil.root_pattern(".git", "README.md"),
		settings = {},
	},
}

require("lspconfig.configs").gleam = {
	default_config = {
		cmd = { "gleam", "lsp" },
		filetypes = { "gleam" },
		root_dir = lsputil.root_pattern(".git", "README.md"),
		settings = {},
	},
}

local lspconfig = require("lspconfig")
lspconfig.pb.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		client.server_capabilities.semanticTokensProvider = false
	end,
	settings = {},
	root_dir = lsputil.root_pattern(".git", "README.md"),
	filetypes = { "proto", "ev" },
	cmd = { "pb", "lsp" },
})

local lspconfig = require("lspconfig")
lspconfig.gleam.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		-- client.server_capabilities.semanticTokensProvider = false
	end,
	settings = {},
	root_dir = lsputil.root_pattern(".git", "README.md"),
	filetypes = { "gleam" },
	cmd = { "gleam", "lsp" },
})

local servers = {
	yamlls = {
		yaml = {
			schemaStore = {
				-- You must disable built-in schemaStore support if you want to use
				-- this plugin and its advanced options like `ignore`.
				enable = false,
				-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
				url = "",
			},
			schemas = require("schemastore").yaml.schemas(),
		},
	},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			completion = {
				callSnippet = "Replace",
			},
			hint = { enable = true },
			format = {
				enable = true,
				-- Put format options here
				-- NOTE: the value should be STRING!!
				defaultConfig = {
					indent_style = "space",
					indent_size = "4",
				},
			},
		},
	},
	tailwindcss = {},
}

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
	automatic_installation = true,
	ensure_installed = {
		"yamlls",
		"jsonls",
		"jdtls",
		"bashls",
		"clangd",
		"cssls",
		"html",
		"eslint",
		"gopls",
		"lua_ls",
		"marksman",
		"neocmake",
		"pyright",
		"texlab",
		"docker_compose_language_service",
		"dockerls",
		"bufls",
		"tailwindcss",
	},
})

mason_lspconfig.setup_handlers({
	["jdtls"] = function() end, --- jdtls.nvim sets lsp itself
	["gopls"] = function()
		lspconfig.gopls.setup({
			cmd = { require("lsp.defaults").MASON_BIN .. "/gopls" },
			capabilities = capabilities,
			on_attach = on_attach,
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
			root_dir = lsputil.root_pattern(".git", "go.work", "go.mod"),
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			-- fillstruct = 'gopls',
		})
	end,
	["pyright"] = function()
		lspconfig.pyright.setup({
			root_dir = lsputil.root_pattern(
				".git",
				"pyrightconfig.json",
				".venv",
				"venv",
				"README.md",
				"Pipfile",
				"pyproject.toml"
			),
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
				client.server_capabilities.documentFormattingProvider = false
			end,
			settings = {
				single_file_support = true,
				pyright = {
					autoImportCompletion = true,
					disableLanguageServices = false,
					disableOrganizeImports = false,
				},
				python = {
					analysis = {
						autoImportCompletions = true,
						autoSearchPaths = true,
						diagnosticMode = "workspace", -- openFilesOnly, workspace
						useLibraryCodeForTypes = true,
						typeCheckingMode = "basic", -- 'strict'
					},
				},
			},
		})
	end,
	["bufls"] = function()
		lspconfig.bufls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {},
			root_dir = lsputil.root_pattern(".git", "README.md"),
			filetypes = { "proto", "ev" },
		})
	end,
	["html"] = function()
		lspconfig["html"].setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
				client.server_capabilities.documentRangeFormattingProvider = false
				client.server_capabilities.documentFormattingProvider = false
			end,
			filetypes = { "html", "templ", "template" },
			settings = {
				html = {
					hover = {
						documentation = true,
						references = true,
					},
				},
			},
		})
	end,
	["clangd"] = function()
		lspconfig.clangd.setup({
			root_dir = function(fname)
				return lsputil.root_pattern(
					"Makefile",
					"configure.ac",
					"configure.in",
					"config.h.in",
					"meson.build",
					"meson_options.txt",
					"build.ninja"
				)(fname) or lsputil.root_pattern("compile_commands.json", "compile_flags.txt")(fname) or lsputil.find_git_ancestor(
					fname
				)
			end,
			capabilities = vim.tbl_extend("keep", capabilities, { offsetEncoding = "utf-8" }),
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
				vim.keymap.set(
					"n",
					"<leader>ch",
					require("clangd_extensions.switch_source_header").switch_source_header,
					{ desc = "[c]langd switch source [h]eader", buffer = bufnr }
				)
			end,
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
			cmd = {
				require("lsp.defaults").MASON_BIN .. "/clangd",
				"--background-index",
				string.format("-j=%d", #vim.loop.cpu_info()),
				"--header-insertion=iwyu",
				"--all-scopes-completion",
				"--completion-style=detailed",
				"--pch-storage=memory",
			},
			settings = {},
		})
	end,
	["lua_ls"] = function()
		require("neodev").setup()
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers["lua_ls"],
		})
	end,
	["jsonls"] = function()
		lspconfig["jsonls"].setup({
			root_dir = lsputil.root_pattern(".git", "README.md"),
			capabilities = capabilities,
			settings = {
				json = {
					schemas = require("schemastore").json.schemas({
						extra = {},
					}),
					validate = { enable = true },
				},
			},
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
			end,
		})
	end,
	["eslint"] = function()
		lspconfig["eslint"].setup({
			root_dir = lsputil.root_pattern(".git", ".eslintrc"),
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				-- client.server_capabilities.document_formatting = true
				on_attach(client, bufnr)
			end,
			settings = {
				format = { enable = true }, -- this will enable formatting
			},
		})
	end,
	["tailwindcss"] = function()
		lspconfig.tailwindcss.setup({
			root_dir = lsputil.root_pattern(
				"tailwind.config.js",
				"tailwind.config.cjs",
				"tailwind.config.mjs",
				"tailwind.config.ts",
				"postcss.config.js",
				"postcss.config.cjs",
				"postcss.config.mjs",
				"postcss.config.ts",
				"package.json",
				"node_modules",
				".git"
			),
			capabilities = capabilities,
			on_attach = on_attach,
			-- function(client, bufnr)
			-- if client.server_capabilities.colorProvider then
			--     require("colorizer").attach_to_buffer(
			--         bufnr,
			--         { mode = "background", css = true, names = false, tailwind = false }
			--     )
			-- end
			-- end,
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
	end,
	function(server_name)
		lspconfig[server_name].setup({
			root_dir = lsputil.root_pattern(".git", "README.md"),
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
		})
	end,
})
