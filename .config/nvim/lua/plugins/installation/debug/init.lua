return {
    'mfussenegger/nvim-dap',
    dependencies = {
        -- Creates a beautiful debugger UI
        'rcarriga/nvim-dap-ui',
        {
            'theHamsta/nvim-dap-virtual-text',
            opts = {}
        },
        { "Weissle/persistent-breakpoints.nvim", opts = { load_breakpoints_event = { "BufReadPost" } } },
        'nvim-telescope/telescope-dap.nvim',
        {
            "rcarriga/cmp-dap",
            dependencies = { "nvim-cmp" },
            config = function()
                require("cmp").setup.filetype(
                    { "dap-repl", "dapui_watches", "dapui_hover" },
                    {
                        sources = {
                            { name = "dap" },
                        },
                    }
                )
            end,
        },
        { 'LiadOz/nvim-dap-repl-highlights',     opts = {} },

        -- Installs the debug adapters for you
        'jay-babu/mason-nvim-dap.nvim',

        {
            'mfussenegger/nvim-dap-python',
            config = function()
                local path = require("lsp/defaults").MASON_PACKAGES .. "/debugpy/venv/bin/python"
                require("dap-python").setup(path)
            end
        },
        {
            'leoluz/nvim-dap-go',
            ft = "go",
            config = function()
                require("dap-go").setup({
                    delve = {
                        path = require("lsp.defaults").MASON_BIN .. "/dlv",
                    }
                })

                local DELVE_LAUNCH_NAME = "[overseer delve] debug"

                local dap = require("dap")
                dap.adapters.delve = function(cb, config)
                    if config.name == DELVE_LAUNCH_NAME then
                        local overseer = require("overseer")
                        overseer.run_template({ name = "launch delve" }, function(task)
                            if task then
                                local main_win = vim.api.nvim_get_current_win()
                                overseer.run_action(task, "open vsplit")
                                vim.api.nvim_set_current_win(main_win)
                            else
                                vim.notify("Couldn't start delve debugger", vim.log.levels.ERROR)
                            end
                        end)
                    end

                    if config.preLaunchTask then vim.fn.system(config.preLaunchTask) end
                    local adapter = {
                        type = "server",
                        host = "127.0.0.1",
                        port = 38697, -- overseer/template/user/launch_delve.lua
                    }
                    cb(adapter)
                end

                table.insert(
                    dap.configurations.go,
                    {
                        type = "delve",
                        name = DELVE_LAUNCH_NAME,
                        request = "launch",
                        program = "${file}"
                    }
                )

                vim.api.nvim_create_user_command("DelveLaunch", function()
                    local overseer = require("overseer")
                    overseer.run_template({ name = "launch delve" }, function(task)
                        if task then
                            local main_win = vim.api.nvim_get_current_win()
                            overseer.run_action(task, "open vsplit")
                            vim.api.nvim_set_current_win(main_win)
                        else
                            vim.notify("WatchRun not supported for filetype " .. vim.bo.filetype, vim.log.levels.ERROR)
                        end
                    end)
                end, {})
            end
        },
    },
    config = function()
        require("plugins/installation/debug/dapui").setup()
    end,
}
