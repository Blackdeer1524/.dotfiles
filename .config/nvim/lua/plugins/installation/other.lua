local M = {
    {
        -- a plugin for creating tests
        'xeluxee/competitest.nvim',
        dependencies = 'MunifTanjim/nui.nvim',
        opts = {
            testcases_directory = "./txt_tests",
            compile_command = {
                cpp = { exec = "cmake", args = { "--build", "./build", "--target", "main" } },
                go = { exec = "go", args = { "build", "-o", "main", "$(FNAME)" } },
            },
            run_command = {
                cpp = { exec = "./build/main" },
                go = { exec = "./main" },
            },
            runner_ui = {
                interface = "split"
            },
        },
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",

            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",

            "nvim-neotest/neotest-go",
            "rouge8/neotest-rust",
            "alfaix/neotest-gtest",
            "nvim-neotest/neotest-python",
        },
        config = function()
            -- get neotest namespace (api call creates or returns namespace)
            local neotest_ns = vim.api.nvim_create_namespace("neotest")
            vim.diagnostic.config({
                virtual_text = {
                    format = function(diagnostic)
                        local message =
                            diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
                        return message
                    end,
                },
            }, neotest_ns)

            local utils = require("neotest-gtest.utils")
            local lib = require("neotest.lib")
            ---@diagnostic disable-next-line: missing-fields
            require("neotest").setup({
                consumers = {
                    overseer = require("neotest.consumers.overseer"),
                },
                adapters = {
                    require("neotest-go"),
                    require("neotest-python") {
                        is_test_file = function(file_path)
                            if string.find(file_path, "test") then
                                return true
                            else
                                return false
                            end
                        end,
                    },
                    require("neotest-rust") {
                        args = { "--no-capture" },
                        dap_adapter = "codelldb",
                    },
                    require("neotest-gtest").setup({
                        -- dap.adapters.<this debug_adapter> must be set for debugging to work
                        -- see "installation" section above for installing and setting it up
                        debug_adapter = "codelldb",

                        -- Must be set to a function that takes a single string argument (full path to file)
                        -- and returns its root. `neotest` provides a utility match_root_pattern,
                        -- which will return the first parent directory containing one of these file names
                        root = lib.files.match_root_pattern(
                            "compile_commands.json",
                            "compile_flags.txt",
                            ".clangd",
                            "init.lua",
                            "init.vim",
                            "build",
                            ".git"
                        ),

                        -- takes full path to the file and returns true if it's a test file, false otherwise
                        -- by default, returns true for all cpp files starting with "test_" or ending with
                        -- "_test"
                        is_test_file = utils.is_test_file
                    }
                    )
                },
            })
        end
    },
    {
        'stevearc/overseer.nvim',
        opts = {
            dap = false, -- dap is turned in separate file
            templates = { "builtin", "user.launch_delve" },
            task_list = {
                max_width = 0.99,
                min_width = 0.0,
                width = 0.3,
                direction = "right",

                bindings = {
                    ["<C-v>"] = false,
                    ["<C-|>"] = "OpenVsplit",
                    ["<C-s>"] = false,
                    ["<C-\\>"] = "OpenSplit",

                    ["<C-k>"] = false,
                    ["<C-j>"] = false,
                    ["<C-l>"] = false,
                    ["<C-h>"] = false,
                },
            },
        },
    },
    {
        -- perf annotations
        "t-troebst/perfanno.nvim",
        config = function()
            local perfanno = require("perfanno")
            local util = require("perfanno.util")

            -- local bgcolor = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg", "gui")
            perfanno.setup {
                -- line_highlights = util.make_bg_highlights(bgcolor, "#504ECD", 10),
                vt_highlight = util.make_fg_highlight("#504ECD"),
            }
        end,
    },
    {
        'stevearc/dressing.nvim',
        opts = {
            select = {
                get_config = function()
                    if vim.api.nvim_buf_get_option(0, "filetype") == "idris2" then
                        return { enabled = false }
                    end
                end,
            },
        },
    },
    {
        'glacambre/firenvim',
        enabled = false,
        lazy = not vim.g.started_by_firenvim,
        config = function()
            if vim.g.started_by_firenvim == true then
                vim.g.firenvim_config = {
                    localSettings = {
                        ['.*'] = {
                            filename = os.getenv("HOME") .. '/tmp/{hostname}_{pathname%10}.cpp'
                        }
                    }
                }
            end
        end,
        build = function()
            vim.fn["firenvim#install"](0)
        end
    },
    {
        "LunarVim/bigfile.nvim",
        opts = {
            filesize = 2,      -- size of the file in MiB, the plugin round file sizes to the closest MiB
            pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
            features = {       -- features to disable
                "indent_blankline",
                "illuminate",
                "lsp",
                "treesitter",
                "syntax",
                "matchparen",
                "vimopts",
                "filetype",
            },
        }
    },
    {
        "NMAC427/guess-indent.nvim",
        opts = {}
    },
    {
        "mistricky/codesnap.nvim",
        build = "make",
        opts = {
            mac_window_bar = false,
            title = "",
            code_font_family = "CaskaydiaCove Nerd Font",
            watermark_font_family = "Pacifico",
            watermark = "",
            bg_theme = "default",
            breadcrumbs_separator = "/",
            has_breadcrumbs = false,
            has_line_number = true,
        }
    },
    {
        'jsongerber/thanks.nvim',
        opts = {
            plugin_manager = "lazy",
        },
        commit = "6ab4a52",
        enabled = false,
    },
}


return M
