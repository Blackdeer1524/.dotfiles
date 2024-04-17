-- names of DAPs
-- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
require('mason-nvim-dap').setup {
    ensure_installed = {
        "codelldb",
        "delve",
        "cppdbg",
        "python",
        "js",
        "chrome",
        "javadbg",
        "javatest",
    },
}

require("mason-setup.debug.adapters")
require("mason-setup.debug.langs")
