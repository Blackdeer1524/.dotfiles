local HEIGHT_RATIO = 0.8 -- You can change this
local WIDTH_RATIO = 0.5  -- You can change this too

local M = {
    {
        -- terminal emulator
        'akinsho/toggleterm.nvim',
        version = "*",
        enabled = false,
        opts = {
            open_mapping = [[<leader>tt]],
            start_in_insert = true,
            insert_mappings = false,   -- whether or not the open mapping applies in insert mode
            terminal_mappings = false, -- whether or not the open mapping applies in the opened terminals
        }
    },
    {
        -- diagnostics list
        'folke/trouble.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
    },
    {
        -- floating notifications
        'rcarriga/nvim-notify',
        config = function()
            require("notify").setup {
                stages = 'static',
                timeout = 2000,
            }
            local banned_messages = { "No information available" }
            vim.notify = function(msg, ...)
                for _, banned in ipairs(banned_messages) do
                    if msg == banned then
                        return
                    end
                end
                return require("notify")(msg, ...)
            end
        end,
        lazy = false,
    },
    {
        -- buffers line
        'romgrk/barbar.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
            animation = false,
            -- insert_at_start = true,
            -- …etc.
        },
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
        enabled = false,
    },
    {
        "mbbill/undotree",
    },
    {
        'stevearc/oil.nvim',
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            buf_options = {
                buflisted = true,
                bufhidden = "hide",
            },
            keymaps = {
                ["<C-s>"] = false,
                ["<C-|>"] = "actions.select_vsplit",

                ["<C-h>"] = false,
                ["<C-\\>"] = "actions.select_split",

                ["<C-l>"] = false,
                ["<C-r>"] = "actions.refresh",
            },
        },
    },
    {
        'nvim-tree/nvim-web-devicons',
        config = function()
            local custom_icons = {}
            for _, v in pairs({ "mp3", "wav", "aac", "flac", "m4a", "wma", "ogg", "opus", "aiff", "au" }) do
                custom_icons[v] = {
                    icon = "",
                    name = v,
                    color = "#672168"
                }
            end
            custom_icons["pyw"] = {
                icon = "󰌠",
                name = "PythonNoConsole"
            }
            custom_icons["apkg"] = {
                icon = "󰘸",
                name = "AnkiPackage"
            }
            custom_icons["proto"] = {
                icon = "󱁜",
                name = "protobufs"
            }
            custom_icons["ev"] = custom_icons["proto"]

            custom_icons["toml"] = {
                icon = "",
                name = "toml"
            }

            custom_icons["make"] = {
                icon = "󰣪",
                name = "make",
            }

            require("nvim-web-devicons").setup({
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
                override_by_extension = custom_icons
            })
        end
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        opts = {
            view = {
                preserve_window_proportions = false,
            },
            actions = {
                open_file = {
                    resize_window = true,
                },
            },
            renderer = {
                indent_markers = {
                    enable = true
                },
            },
            -- view = {
            --     float = {
            --         enable = true,
            --         open_win_config = function()
            --             local screen_w = vim.opt.columns:get()
            --             local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            --             local window_w = screen_w * WIDTH_RATIO
            --             local window_h = screen_h * HEIGHT_RATIO
            --             local window_w_int = math.floor(window_w)
            --             local window_h_int = math.floor(window_h)
            --             local center_x = (screen_w - window_w) / 2
            --             local center_y = ((vim.opt.lines:get() - window_h) / 2)
            --                 - vim.opt.cmdheight:get()
            --             return {
            --                 border = 'rounded',
            --                 relative = 'editor',
            --                 row = center_y,
            --                 col = center_x,
            --                 width = window_w_int,
            --                 height = window_h_int,
            --             }
            --         end,
            --     },
            --     width = function()
            --         return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
            --     end,
            -- },
        },
    },
    {
        -- search and replace tool
        'nvim-pack/nvim-spectre',
        dependencies = {
            'nvim-lua/plenary.nvim'
        }
    },
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        opts = {
            attach_navic = false,
            show_navic = false,
            include_buftypes = { "", "acwrite" }, -- acwrite buftype is used in oil.nvim
        },
    },
}

return M
