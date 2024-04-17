local M = {
    {
        -- autosave events
        "Pocco81/auto-save.nvim",
        config = function()
            require("auto-save").setup({
                trigger_events = { "InsertLeave", "BufLeave" },
                condition = function(buf)
                    local fn = vim.fn
                    local utils = require("auto-save.utils.data")

                    local status, buf_name = pcall(vim.api.nvim_buf_get_name, buf)
                    if not status then
                        return false
                    end

                    if string.find(buf_name, "harpoon") or string.find(buf_name, "Overseer") then
                        return false
                    end
                    -- vim.notify(buf_name)

                    local oil_protocol = string.sub(buf_name, 1, 6)
                    if
                        fn.getbufvar(buf, "&modifiable") == 1 and
                        utils.not_in(fn.getbufvar(buf, "&filetype"), {}) and
                        oil_protocol ~= "oil://" then
                        return true -- met condition(s), can save
                    end
                    return false    -- can't save
                end,
            })
        end,
    },
    {
        'windwp/nvim-autopairs',
        config = function()
            require("nvim-autopairs").setup()
        end
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    -- Useful plugin to show you pending keybinds.
    { 'folke/which-key.nvim', opts = {} },
    -- quick test suits
    {
        "iamcco/markdown-preview.nvim",
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    {
        "dfendr/clipboard-image.nvim",
        opts = {}
    },
}



return M
