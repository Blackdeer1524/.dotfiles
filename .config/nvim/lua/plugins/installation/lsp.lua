local M = {
    {
        -- LSP Configuration & Pluginsplugins
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
            {
                'j-hui/fidget.nvim',
                opts = {}
            },
            'folke/neodev.nvim',
        },
    },
    {
        "antosha417/nvim-lsp-file-operations",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-tree.lua",
        },
        config = function()
            require("lsp-file-operations").setup()
        end,
    },
    {
        "rmagatti/goto-preview",
        config = function()
            require('goto-preview').setup()
            vim.keymap.set("n", "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
                { noremap = true })
        end,
    },
    {
        "kosayoda/nvim-lightbulb",
        opts = {
            autocmd = { enabled = true, updatetime = 100, },
        }
    },
    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            {
                'L3MON4D3/LuaSnip',
                version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
                -- install jsregexp (optional!).
                build = "make install_jsregexp",
                dependencies = {
                    "rafamadriz/friendly-snippets",
                    exclude = { "cpp" }
                },
            },
            'saadparwaiz1/cmp_luasnip',
            "onsails/lspkind.nvim",
            "hrsh7th/cmp-path",
            "quangnguyen30192/cmp-nvim-tags",
            {
                -- nvim-cmp source for displaying function signatures with
                -- the current parameter emphasized:
                "hrsh7th/cmp-nvim-lsp-signature-help",
            },
            "luckasRanarison/tailwind-tools.nvim",
            "onsails/lspkind-nvim",
        },
    },
    {
        "danymat/neogen",
        version = "*",
        dependencies = {
            "L3MON4D3/LuaSnip"
        },
        config = function()
            require('neogen').setup({ snippet_engine = "luasnip" })
            local opts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap("n", "<Leader>nf", ":lua require('neogen').generate()<CR>", opts)
        end,
    },
    -- multiline diagnostics
    {
        -- "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        "ErichDonGubler/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()

            vim.api.nvim_create_user_command(
                'SwitchDiagnosticsMode',
                function(_)
                    vim.diagnostic.config({
                        virtual_lines = not vim.diagnostic.config(nil)["virtual_lines"],
                        virtual_text = not vim.diagnostic.config(nil)["virtual_text"],
                    })
                end,
                { desc = 'Switch diagnostics mode' }
            )

            vim.keymap.set('n', '<leader>ds', '<Cmd>SwitchDiagnosticsMode<CR>',
                { desc = "[d]iagnostics [s]witch" })
        end,
    },
    'williamboman/mason.nvim',
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "jose-elias-alvarez/null-ls.nvim",
        },
    },
    {
        -- formatting and linting
        "nvimtools/none-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            local SQL_DIALECT = "sqlite"

            local sources = {
                -- C / C++
                null_ls.builtins.diagnostics.cppcheck.with({ extra_args = { "--std=c++20", "--language=c++" } }), -- sudo apt install cppcheck
                null_ls.builtins.diagnostics.cpplint.with({
                    args = { "--filter=-legal" } }),                                                              -- https://github.com/clangd/coc-clangd/issues/345

                -- null_ls.builtins.diagnostics.protolint,
                null_ls.builtins.formatting.buf,

                null_ls.builtins.formatting.clang_format,
                null_ls.builtins.diagnostics.cmake_lint,

                -- Python
                -- null_ls.builtins.diagnostics.ruff,
                null_ls.builtins.formatting.black,
                -- null_ls.builtins.formatting.ruff,

                -- Go
                -- null_ls.builtins.diagnostics.revive,
                null_ls.builtins.formatting.golines.with({
                    extra_args = {
                        "--max-len=80",
                        "--base-formatter=gofumpt",
                    },
                }),
                null_ls.builtins.diagnostics.golangci_lint.with({
                    command = require("lsp.defaults").MASON_BIN .. "/golangci-lint"
                }),
                -- Markdown
                -- null_ls.builtins.diagnostics.markdownlint,

                -- SQL
                null_ls.builtins.diagnostics.sqlfluff.with({
                    command = require("lsp.defaults").MASON_BIN .. "/sqlfluff",
                    extra_args = { "--dialect", SQL_DIALECT }, -- change to your dialect
                }),
                null_ls.builtins.formatting.sqlfluff.with({
                    command = require("lsp.defaults").MASON_BIN .. "/sqlfluff",
                    extra_args = { "--dialect", SQL_DIALECT }, -- change to your dialect
                }),

                -- TS/JS
                null_ls.builtins.formatting.prettier.with({
                    command = require("lsp.defaults").MASON_BIN .. "/prettier",
                }
                ),

                --css
                -- null_ls.builtins.diagnostics.stylelint.with({
                --     command = require("lsp.defaults").MASON_BIN .. "/stylelint",
                -- })
            }
            null_ls.setup({ sources = sources })
        end
    },
    {
        -- Inlay hints. For new languages !!follow!! https://github.com/lvimuser/lsp-inlayhints.nvim
        "lvimuser/lsp-inlayhints.nvim",
        opts = {},
        enabled = false,
    },
    {
        'p00f/clangd_extensions.nvim',
        opts = {
            -- inlay_hints = {
            --     inline = 0,
            -- }
        }
    },
    {
        "mrcjkb/rustaceanvim",
        config = function()
            vim.g.rustaceanvim = function()
                local package_path = require("lsp.defaults").MASON_PACKAGES .. "/codelldb"
                local codelldb_path = package_path .. "/codelldb"
                local liblldb_path = package_path .. "/extension/lldb/lib/liblldb"
                local this_os = vim.loop.os_uname().sysname

                -- The path in windows is different
                if this_os:find "Windows" then
                    codelldb_path = package_path .. "\\extension\\adapter\\codelldb.exe"
                    liblldb_path = package_path .. "\\extension\\lldb\\bin\\liblldb.dll"
                else
                    -- The liblldb extension is .so for linux and .dylib for macOS
                    liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
                end

                local adapter = require('rustaceanvim.config').get_codelldb_adapter(codelldb_path, liblldb_path)
                return {
                    dap = {
                        adapter = adapter
                    },
                    server = {
                        settings = {
                            ["rust-analyzer"] = {
                                -- checkOnSave = {
                                --     command = "clippy",
                                -- },
                            },
                        },
                        on_attach = function(_, bufnr)
                            require('lsp.defaults').on_attach(_, bufnr)
                            vim.keymap.set("n", "<leader>rd", "<cmd>RustLsp debuggables<cr>",
                                { buffer = bufnr, desc = "RustLps debuggables" })
                        end,
                    },
                    tools = {
                        -- inlay_hints = {
                        --     auto = false
                        -- },
                        hover_actions = {
                            replace_builtin_hover = false
                        }
                    }
                }
            end
        end,
    },
    {
        'Civitasv/cmake-tools.nvim',
        config = function()
            require("cmake-tools").setup({
                cmake_build_directory = "build",
                cmake_build_directory_prefix = "", -- It seems that you can't select build dir
                cmake_executor = { name = "overseer", opts = {} }
            })

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
                pattern = { "*.c", "*.cc", "*.cpp", "*.h", ".hpp" },
                callback = function(ev)
                    require("which-key").register({
                        ["<leader>c"] = {
                            name = "+cmake",
                            b = { "<cmd>CMakeBuild<cr>", "[c]make [b]uild" },
                            d = { "<cmd>CMakeDebug<cr>", "[c]make [d]ebug" },
                            r = { "<cmd>CMakeRun<cr>", "[c]make [r]un" },
                            g = { "<cmd>CMakeGenerate<cr>", "[c]make [g]enerate" },
                            l = { "<cmd>CMakeLaunchArgs<cr>", "[c]make [l]aunch args" },
                            s = {
                                name = "+select",
                                k = { "<cmd>CMakeSelectKit<cr>", "[c]make [s]elect [k]it" },
                                l = { "<cmd>CMakeSelectLaunchTarget<cr>", "[c]make [s]elect [l]aunch target" },
                                b = { "<cmd>CMakeSelectBuildTarget<cr>", "[c]make [s]elect [b]uild target" },
                                t = { "<cmd>CMakeSelectBuildType<cr>", "[c]make [s]elect build [t]ype" },
                            },
                        },
                    })
                end
            })
        end
    },
    {
        'saecki/crates.nvim',
        tag = 'v0.3.0',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('crates').setup()
        end,
    },
    {
        "mfussenegger/nvim-jdtls",
    },
    {
        "aznhe21/actions-preview.nvim",
        config = function()
            require("actions-preview").setup {
                -- options for vim.diff(): https://neovim.io/doc/user/lua.html#vim.diff()
                diff = {
                    ctxlen = 3,
                },
                -- priority list of preferred backend
                backend = { "telescope" },

                -- options related to telescope.nvim
                -- telescope = vim.tbl_extend(
                --     "force",
                --     -- telescope theme: https://github.com/nvim-telescope/telescope.nvim#themes
                --     require("telescope.themes").get_cursor({
                --         layout_strategy = "cursor",
                --         initial_mode = "normal",
                --         layout_config = {
                --             width = function(_, max_columns)
                --                 local max = 150
                --                 return math.min(max_columns, max)
                --             end,
                --             height = function(_, _, max_lines)
                --                 local res = math.min(math.max(math.ceil(max_lines * 0.5), 0), 20)
                --                 return res
                --             end,
                --             preview_width = 80,
                --         },
                --     }),
                --     -- a table for customizing content
                --     {
                --         -- a function to make a table containing the values to be displayed.
                --         -- fun(action: Action): { title: string, client_name: string|nil }
                --         make_value = nil,
                --
                --         -- a function to make a function to be used in `display` of a entry.
                --         -- see also `:h telescope.make_entry` and `:h telescope.pickers.entry_display`.
                --         -- fun(values: { index: integer, action: Action, title: string, client_name: string }[]): function
                --         make_make_display = nil,
                --     }
                -- ),
            }
            vim.keymap.set({ "v", "n" }, "<leader>ca", require("actions-preview").code_actions)
        end,

    },
    {
        -- json / yaml schemas annotations
        "b0o/schemastore.nvim",
    },
    {
        "lervag/vimtex",
    },
    {
        'Julian/lean.nvim',
        event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },
        dependencies = {
            'neovim/nvim-lspconfig',
            'nvim-lua/plenary.nvim',
        },
        opts = {
            lsp = {
                on_attach = require("lsp.defaults").on_attach,
            },
            mappings = true,
        }
    },
    {
        'ShinKage/idris2-nvim',
        dependencies = {
            'neovim/nvim-lspconfig',
            'MunifTanjim/nui.nvim'
        },
        event = { 'BufReadPre *.idr', 'BufNewFile *.idr' },
        opts = {
            server = {
                on_attach = function(client, bufnr)
                    require("lsp.defaults").on_attach(client, bufnr)
                    local idris = require("idris2")
                    local idris2_ca = require("idris2.code_action")

                    vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPre" }, {
                        buffer = bufnr,
                        callback = function(ev)
                            require("which-key").register({
                                buffer = bufnr,
                                ["<leader>"] = {
                                    i = {
                                        name = "+idris",
                                        m = {
                                            name = "+make",
                                            c = { idris2_ca.make_case, "make case" },
                                            w = { idris2_ca.make_with, "make with" },
                                            l = { idris2_ca.make_lemma, "make lemma" },
                                        },
                                        rh = { idris2_ca.refine_hole, "refine hole" },
                                        re = { require("idris2.repl").evaluate, "repl evaluate" },
                                        e = {
                                            name = "+expression",
                                            s = { idris2_ca.expr_search, "expression search" },
                                            h = { idris2_ca.expr_search_hints, "expression search hint" }
                                        },
                                        i = { idris2_ca.intro, "intro" },
                                        a = { idris2_ca.add_clause, "add clause" },
                                        g = { idris2_ca.generate_def, "generate definition" },

                                        sc = { idris2_ca.case_split, "split case" },
                                        si = { idris.show_implicits, "Show implicits in hovers" },
                                        sm = { idris.show_machine_names, "Show machine names in hovers" },
                                        sr = {
                                            function()
                                                require("idris2.semantic").request(0)
                                            end,
                                            "Requests semantic groups"
                                        },

                                        h = {
                                            name = "+hide",
                                            i = { idris.hide_implicits, "Hide implicits in hovers" },
                                            m = { idris.hide_machine_names, "Hide machine names in hovers" },
                                            n = { idris.hide_namespace, "Hide namespaces in hovers" },
                                        },

                                        f = { idris.full_namespace, "Show full namespaces in hovers" },

                                        b = { require("idris2.browse").browse, "browse" },

                                        os = { function() require("idris2.hover").open_split() end, "open split" },
                                        cs = { require("idris2.hover").close_split, "close split" },
                                    },
                                },
                            })
                        end,
                    })
                end
            }
        }
    },
    {
        "hedyhli/outline.nvim",
        config = function()
            require("outline").setup()
            vim.keymap.set("n", "<leader>so", "<cmd>Outline<cr>", { desc = "[s]ymbols [o]utline" })
        end
    },
    {
        'linux-cultist/venv-selector.nvim',
        dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
        opts = {
            name = { ".venv", "venv" },
            auto_refresh = false,
            dap_enabled = true,
            search = true,
            parents = 0,
        },
        event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
        keys = {
            -- Keymap to open VenvSelector to pick a venv.
            { '<leader>vs', '<cmd>VenvSelect<cr>' },
            -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
            { '<leader>vc', '<cmd>VenvSelectCached<cr>' },
        },
    },
    {
        "scalameta/nvim-metals",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "skywind3000/gutentags_plus",
        ft = { "c", "cpp" },
        dependencies = { "ludovicchabant/vim-gutentags" },
        init = function()
            vim.g.gutentags_plus_nomap = 1
            vim.g.gutentags_resolve_symlinks = 1
            vim.g.gutentags_cache_dir = vim.fn.stdpath "cache" .. "/tags"
            vim.api.nvim_create_autocmd("FileType", {
                desc = "Auto generate C/C++ tags",
                callback = function()
                    local is_c = vim.bo.filetype == "c" or vim.bo.filetype == "cpp"
                    if is_c then
                        vim.g.gutentags_enabled = 1
                    else
                        vim.g.gutentags_enabled = 0
                    end
                end,
            })
        end,
    },
    {
        "zeioth/garbage-day.nvim",
        dependencies = "neovim/nvim-lspconfig",
        event = "VeryLazy",
        opts = {
            grace_period = 10 * 60,
            notifications = true
        }
    },
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {},
        config = function()
            require("typescript-tools").setup {
                on_attach =
                    function(client, bufnr)
                        client.server_capabilities.documentFormattingProvider = false
                        client.server_capabilities.documentRangeFormattingProvider = false
                        require("lsp.defaults").on_attach(client, bufnr, true)
                        vim.keymap.set('n', "gs", "<cmd>TSToolsGoToSourceDefinition<cr>", { buffer = bufnr })
                    end,
                settings = {
                    tsserver_file_preferences = {
                        includeInlayParameterNameHints = 'all',
                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                        includeInlayFunctionParameterTypeHints = false,
                        includeInlayVariableTypeHints = false,
                        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    },
                    jsx_close_tag = {
                        enable = false,
                        filetypes = { "javascriptreact", "typescriptreact" },
                    }
                },
            }
        end
    },
    {
        "luckasRanarison/tailwind-tools.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            conceal = {
                enabled = false, -- can be toggled by commands
                min_length = nil, -- only conceal classes exceeding the provided length
                symbol = "󱏿", -- only a single character is allowed
                highlight = { -- extmark highlight options, see :h 'highlight'
                    fg = "#38BDF8",
                },
            },
        }
    },
    {
        "MaximilianLloyd/tw-values.nvim",
        keys = {
            { "<leader>sv", "<cmd>TWValues<cr>", desc = "Show tailwind CSS values" },
        },
        opts = {
            border = "rounded",          -- Valid window border style,
            show_unknown_classes = true, -- Shows the unknown classes popup
            focus_preview = true,        -- Sets the preview as the current window
            copy_register = "",          -- The register to copy values to,
            keymaps = {
                copy = "<C-y>"           -- Normal mode keymap to copy the CSS values between {}
            }
        }
    },
    {
        "Fildo7525/pretty_hover",
        event = "LspAttach",
        opts = {},
    },
    {
        "icholy/lsplinks.nvim",
        config = function()
            local lsplinks = require("lsplinks")
            lsplinks.setup()
            vim.keymap.set("n", "gx", lsplinks.gx)
        end
    },
}

return M
