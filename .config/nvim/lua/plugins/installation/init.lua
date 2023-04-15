-- nvim-tree.lua
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local audio_ext_cfg = {}
for _, v in pairs({ "mp3", "wav", "aac", "flac", "m4a", "wma", "ogg", "opus", "aiff", "au" }) do
    audio_ext_cfg[v] = {
        icon = "",
        name = v,
        color = "#672168"
    }
end

audio_ext_cfg["pyw"] = {
    icon = "󰌠",
    name = "PythonNoConsole"
}
audio_ext_cfg["apkg"] = {
    icon = "󰘸",
    name = "AnkiPackage"
}

return {
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        opts = {
            open_mapping = [[<c-\>]],
        }
    },
    {
        'windwp/nvim-autopairs',
        config = function()
            require("nvim-autopairs").setup()
        end
    },
    {
        "tpope/vim-surround",
    },
    {
        'nvim-pack/nvim-spectre',
        dependencies = {
            'nvim-lua/plenary.nvim'
        }
    },
    {
        'folke/trouble.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
    },
    {
        'rcarriga/nvim-notify',
        config = function()
            vim.notify = require("notify")
        end
    },
    {
        'romgrk/barbar.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
            animation = false,
            -- insert_at_start = true,
            -- …etc.
        },
        -- version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },
    {
        "simrat39/symbols-outline.nvim",
        opts = {},
    },
    {
        "mbbill/undotree",
    },
    {
        "Pocco81/auto-save.nvim",
        opts = { trigger_events = { "InsertLeave", "BufLeave" } }
    },
    {
        "iamcco/markdown-preview.nvim",
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    {
        "lervag/vimtex",
    },
    {
        'rmagatti/auto-session',
        opts = {
            auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
            log_level = "error",
        }
    },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            {
                'nvim-tree/nvim-web-devicons',
                opts = {
                    -- globally enable different highlight colors per icon (default to true)
                    -- if set to false all icons will have the default icon's color
                    color_icons = true,
                    -- globally enable default icons (default to false)
                    -- will get overriden by `get_icons` option
                    default = true,
                    -- globally enable "strict" selection of icons - icon will be looked up in
                    -- different tables, first by filename, and if not found by extension; this
                    -- prevents cases when file doesn't have any extension but still gets some icon
                    -- because its name happened to match some extension (default to false)
                    strict = true,
                    -- same as `override` but specifically for overrides by filename
                    -- takes effect when `strict` is true
                    override_by_filename = {
                        -- [".gitignore"] = {
                        --     icon = "",
                        --     name = "Gitignore"
                        -- }
                    },
                    override_by_extension = audio_ext_cfg
                },
            },
        },
        opts = {
            git = {
                ignore = false,
            },
            -- renderer = {
            --     icons = {
            --         glyphs = {
            --             folder = {
            --                 empty = "",
            --                 empty_open = "",
            --                 default = "",
            --                 open = "",
            --                 arrow_open = "",
            --             }
            --         }
            --     }
            -- }
        }
    },
    -- Git related plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require("gitsigns").setup()
        end
    },
    -- NOTE: This is where your plugins related to LSP can be installed.
    -- The configuration is done below. Search for lspconfig to find it below.
    {
        "RRethy/vim-illuminate",
    },
    {
        -- LSP Configuration & Pluginsplugins
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim', opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            'folke/neodev.nvim',
        },
    },
    {
        "glepnir/lspsaga.nvim",
        event = "LspAttach",
        config = function()
            require("lspsaga").setup({})
            vim.keymap.set('n', "gP", "<cmd>Lspsaga peek_definition<CR>", { desc = "peek definition" })
        end,
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
            --Please make sure you install markdown and markdown_inline parser
            { "nvim-treesitter/nvim-treesitter" }
        }
    },
    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            "onsails/lspkind.nvim"
        },
    },
    {
        "rafamadriz/friendly-snippets",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },

    -- Useful plugin to show you pending keybinds.
    { 'folke/which-key.nvim',  opts = {} },
    {
        -- Adds git releated signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },
    {
        -- Theme inspired by Atom
        'navarasu/onedark.nvim',
        priority = 1000,
        config = function()
            vim.cmd.colorscheme 'onedark'
        end,
    },
    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        -- See `:help lualine.txt`
        opts = {
            options = {
                icons_enabled = true,
                theme = 'onedark',
                component_separators = '|',
                section_separators = '',
            },
        },
    },
    {
        -- Add indentation guides even on blank lines
        'lukas-reineke/indent-blankline.nvim',
        -- Enable `lukas-reineke/indent-blankline.nvim`
        -- See `:help indent_blankline.txt`
        opts = {
            char = '┊',
            show_trailing_blankline_indent = false,
        },
    },
    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim', opts = {} },

    {
        'EthanJWright/vs-tasks.nvim',
        dependencies = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            -- Fuzzy Finder (files, lsp, etc)
            {
                'nvim-telescope/telescope.nvim',
                version = '*',
                dependencies = { 'nvim-lua/plenary.nvim' }
            },
        },
    },

    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end,
    },
    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        config = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {}
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            local sources = {
                -- C / C++
                null_ls.builtins.diagnostics.clang_check.with({ extra_args = { "-std=c++20" } }), -- sudo apt install clang-tools
                null_ls.builtins.diagnostics.cppcheck.with({ extra_args = { "--std=c++20" } }),   -- sudo apt install cppcheck
                null_ls.builtins.diagnostics.cpplint,                                             -- https://github.com/clangd/coc-clangd/issues/345

                null_ls.builtins.formatting.clang_format,
                null_ls.builtins.diagnostics.cmake_lint,

                -- Go
                null_ls.builtins.diagnostics.revive,
                null_ls.builtins.formatting.golines.with({
                    extra_args = {
                        "--max-len=80",
                        "--base-formatter=gofumpt",
                    },
                }),

                -- Javascript
                null_ls.builtins.formatting.prettier,

                -- Python
                null_ls.builtins.diagnostics.mypy,
                null_ls.builtins.formatting.black.with({
                    extra_args = { "--line-length=80" }
                }),
                null_ls.builtins.formatting.isort,

                -- Markdown

                null_ls.builtins.diagnostics.markdownlint,
            }

            -- for go.nvim
            local gotest = require("go.null_ls").gotest()
            local gotest_codeaction = require("go.null_ls").gotest_action()
            local golangci_lint = require("go.null_ls").golangci_lint()
            table.insert(sources, gotest)
            table.insert(sources, golangci_lint)
            table.insert(sources, gotest_codeaction)
            null_ls.setup({ sources = sources, debounce = 1000, default_timeout = 5000 })

            -- null_ls.register(gotest)
        end
    },
    -- Inlay hints. For new languages !!follow!! https://github.com/lvimuser/lsp-inlayhints.nvim
    {
        "lvimuser/lsp-inlayhints.nvim",
        config = function()
            require("lsp-inlayhints").setup()
            vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
            vim.api.nvim_create_autocmd("LspAttach", {
                group = "LspAttach_inlayhints",
                callback = function(args)
                    if not (args.data and args.data.client_id) then
                        return
                    end

                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    require("lsp-inlayhints").on_attach(client, bufnr)
                end,
            })
        end
    },
    {
        'p00f/clangd_extensions.nvim',
    },
    -- {
    --     'jose-elias-alvarez/typescript.nvim',
    -- },
    {
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("go").setup({
                run_in_floaterm = true,
                icons = false,
                lsp_inlay_hints = {
                    enable = false
                }
            })
        end,
        event = { "CmdlineEnter" },
        ft = { "go", 'gomod' },
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    },
    {
        "simrat39/rust-tools.nvim",
        opts = {
            server = {
                on_attach = require('lsp/defaults').on_attach,
            },
            tools = {
                inlay_hints = {
                    auto = false
                }
            }
        },
    },
    {
        'Civitasv/cmake-tools.nvim',
        opts = {
            cmake_build_directory = "build",
            cmake_build_directory_prefix = "" -- It seems that you can't select build dir
        }
    },
    {
        "mfussenegger/nvim-jdtls",
    },
    {
        "windwp/nvim-ts-autotag",
        opts = {}
    },

    -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
    --       These are some example plugins that I've included in the kickstart repository.
    --       Uncomment any of the lines below to enable them.

    require 'plugins/installation/debug',

    -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
    --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
    --    up-to-date with whatever is in the kickstart repo.
    --
    --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
    --
    --    An additional note is that if you only copied in the `init.lua`, you can just comment this line
    --    to get rid of the warning telling you that there are not plugins in `lua/custom/plugins/`.
}
