local M = {
    {
        "zaldih/themery.nvim",
        dependencies = {
            { "navarasu/onedark.nvim", name = "onedark",    lazy = false,   priority = 1000 },
            { "Shatur/neovim-ayu", },
            { "rebelot/kanagawa.nvim", },
            { "folke/tokyonight.nvim" },
            { "EdenEast/nightfox.nvim" },
            { "catppuccin/nvim",       name = "catppuccin", priority = 1000 },
        },
        lazy = false,
        priority = 1000,
        opts = {
            themes = {
                {
                    name = "Catppuccin latte",
                    colorscheme = "catppuccin-latte",
                },
                {
                    name = "Catppuccin mocha",
                    colorscheme = "catppuccin-mocha",
                },
                {
                    name = "Nightfox",
                    colorscheme = "nightfox",
                    after = [[
                        vim.cmd("highlight WinSeparator guifg=orange")
                    ]]
                },
                {
                    name = "Duskfox",
                    colorscheme = "duskfox",
                    after = [[
                        vim.cmd("highlight WinSeparator guifg=orange")
                    ]]
                },
                {
                    name = "onedark",
                    colorscheme = "onedark"
                },
                {
                    name = "ayu-mirage",
                    colorscheme = "ayu-mirage",
                    after = [[
                        vim.api.nvim_set_hl(0, "LineNr", { fg = '#D6AD5C' })
                    ]]
                },
                -- kanagawa
                {
                    name = "kanagawa-dragon",
                    colorscheme = "kanagawa-dragon"
                },
                {
                    name = "kanagawa-wave",
                    colorscheme = "kanagawa-wave",
                    after = [[
                        vim.api.nvim_set_hl(0, "LineNr", { fg = '#D6AD5C' })
                        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = '#56F3FF', bold=true })
                        vim.cmd("highlight WinSeparator guifg=#D6AD5C")
                    ]]
                },
                -- tokyonight
                {
                    name = "tokyonight-moon",
                    colorscheme = "tokyonight-moon",
                    after = [[
                        vim.api.nvim_set_hl(0, "LineNr", { fg = '#AA8EE3' })
                    ]]
                },
                {
                    name = "tokyonight-night",
                    colorscheme = "tokyonight-night",
                    after = [[
                        vim.api.nvim_set_hl(0, "LineNr", { fg = '#AA8EE3' })
                    ]]
                },
                {
                    name = "tokyonight-storm",
                    colorscheme = "tokyonight-storm",
                    after = [[
                        vim.api.nvim_set_hl(0, "LineNr", { fg = '#AA8EE3' })
                    ]]
                },
            },                                                -- Your list of installed colorschemes
            themeConfigFile = "~/.config/nvim/lua/theme.lua", -- Described below
            livePreview = true,                               -- Apply theme while browsing. Default to true.
        }
    }
}

return M
