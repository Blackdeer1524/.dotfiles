local actived_venv = function()
    local venv_name = require('venv-selector').get_active_venv()
    if venv_name ~= nil then
        return '[venv]: ' .. string.gsub(venv_name, '.*/pypoetry/virtualenvs/', '(poetry) ')
    else
        return ''
    end
end


local M = {
    {
        -- The goal of nvim-ufo is to make Neovim's fold look modern and keep high performance.
        'kevinhwang91/nvim-ufo',
        dependencies = { 'kevinhwang91/promise-async' },
        config = function()
            vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
            vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
            -- setup is called in lsp file
        end,
    },
    {
        "shellRaining/hlchunk.nvim",
        event = { "UIEnter" },
        opts = {
            chunk = {
                enable = true,
                notify = true,
                use_treesitter = true,
                style = {
                    { fg = "#806d9c" },
                    { fg = "#c21f30" }, -- this fg is used to highlight wrong chunk
                },
                exclude_filetypes = {
                    qf = true,
                    help = true,
                    dapui_scopes = true,
                    dapui_watches = true,
                    dapui_stacks = true,
                    dapui_breakpoints = true,
                    dapui_console = true,
                    ["dap-repl"] = true,
                    harpoon = true,
                    dropbar_menu = true,
                    glow = true,
                    aerial = true,
                    dashboard = true,
                    lspinfo = true,
                    lspsagafinder = true,
                    packer = true,
                    checkhealth = true,
                    man = true,
                    mason = true,
                    NvimTree = true,
                    ["neo-tree"] = true,
                    plugin = true,
                    lazy = true,
                    TelescopePrompt = true,
                    [""] = true, -- because TelescopePrompt will set a empty ft, so add this.
                    alpha = true,
                    toggleterm = true,
                    sagafinder = true,
                    sagaoutline = true,
                    better_term = true,
                    fugitiveblame = true,
                    Trouble = true,
                    Outline = true,
                    starter = true,
                    NeogitPopup = true,
                    NeogitStatus = true,
                    DiffviewFiles = true,
                    DiffviewFileHistory = true,
                    DressingInput = true,
                    spectre_panel = true,
                    zsh = true,
                    vuffers = true,
                },
            },
            line_num = {
                enable = false,
            },
            blank = {
                enable = false,
            },
            indent = {
                enable = true,
                use_treesitter = false,
                chars = {
                    "│",
                },
                -- style = {
                --     "#FF0000",
                --     "#FFA500",
                --     "#FFFF00",
                --     "#007000",
                --     "#00BFFF",
                --     "#0000FF",
                --     "#4B0082",
                -- }
            },
        },
    },
    -- -- colors select
    -- {
    --     "uga-rosa/ccc.nvim",
    --     opts = {
    --         highlighter = {
    --             auto_enable = true,
    --             lsp = true,
    --         },
    --     },
    -- },
    {
        -- gui colors select
        "KabbAmine/vCoolor.vim",
        config = function()
            vim.cmd([[let g:vcoolor_disable_mappings = 1]])
            vim.keymap.set({ 'n', 'i' }, "<A-c>", "<cmd>VCoolor<cr>", { desc = "select color", noremap = true, })
        end,
    },
    {
        -- highlights colors:  black blue red yellow #FF00FF
        "NvChad/nvim-colorizer.lua",
        opts = {
            user_default_options = {
                mode = "background"
            },
            filetypes = {
                '*',                                   -- Highlight all files, but customize some others.
                css = { css = true, tailwind = true }, -- Enable parsing rgb(...) functions in css.
                html = { tailwind = true },            -- Disable parsing "names" like Blue or Gray
                js = { tailwind = true },
                ts = { tailwind = true },
            },
        }
    },
    {
        "hiphish/rainbow-delimiters.nvim",
        config = function()
            require('rainbow-delimiters.setup').setup {
                strategy = {
                    -- ...
                },
                query = {
                    -- ...
                },
                highlight = {
                    -- ...
                },
            }
        end
    },
    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        -- See `:help lualine.txt`
        opts = {
            sections = {
                lualine_x = { "overseer" },
                lualine_y = { { function() return require("dap").status() end, color = { fg = "white", bg = "red" } } },
                -- lualine_c = { { "filename", file_status = false, path = 2 } }
                lualine_c = { actived_venv },
            },
            options = {
                icons_enabled = true,
                -- component_separators = { left = '', right = '' },
                -- section_separators = { left = '', right = '' },
            },
        },
    },

}
return M
