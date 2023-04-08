-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>m', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.offsetEncoding = "utf-8"

local servers = {
    clangd = {},
    gopls = {
        gopls = {
            analyses = {
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true
            },
            experimentalPostfixCompletions = true,
            gofumpt = true,
            staticcheck = true,
            usePlaceholders = true,
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true
            }
        }
    },
    pyright = {
    },
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

local on_attach = require("lsp.defaults").on_attach

-- require("clangd_extensions").setup {
--     server = {
--         capabilities = capabilities,
--         on_attach = on_attach,
--         -- options to pass to nvim-lspconfig
--         -- i.e. the arguments to require("lspconfig").clangd.setup({})
--     },
-- }

-- Setup mason so it can manage external tooling
require('mason').setup()

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

local clangd_conf = require("clangd_extensions").prepare(
    {
        server = {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers["clangd"],
            cmd = {
                "clangd",
                "--background-index",
                -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
                -- to add more checks, create .clang-tidy file in the root directory
                -- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
                "--clang-tidy",
                "--completion-style=bundled",
                "--cross-file-rename",
                "--header-insertion=iwyu",
            }
        },
        extensions = {
            autoSetHints = false
        }
    }
)

mason_lspconfig.setup_handlers {
    function(server_name)
        if (server_name == "clangd") then
            require('lspconfig')[server_name].setup(clangd_conf)
        else
            require('lspconfig')[server_name].setup {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = servers[server_name],
            }
        end
    end,
}


vim.api.nvim_create_user_command("ReloadLaunchJson",
    function()
        require('dap.ext.vscode').load_launchjs(nil, { codelldb = { "cpp", "c" } })
    end,
    { nargs = 0 }
)
vim.cmd.ReloadLaunchJson()
