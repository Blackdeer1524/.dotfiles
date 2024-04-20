local dap = require 'dap'

local BASH_DEBUG_ADAPTER_BIN = require("lsp.defaults").MASON_BIN .. "/bash-debug-adapter"
local BASHDB_DIR = require("lsp.defaults").MASON_PACKAGES ..
    "/bash-debug-adapter/extension/bashdb_dir"

dap.adapters.sh = {
    type = "executable",
    command = BASH_DEBUG_ADAPTER_BIN,
}
dap.configurations.sh = {
    {
        name          = "Launch Bash debugger",
        type          = "sh",

        request       = "launch",
        program       = "${file}",

        cwd           = "${fileDirname}",
        pathBashdb    = BASHDB_DIR .. "/bashdb",
        pathBashdbLib = BASHDB_DIR,
        pathBash      = "bash",
        pathCat       = "cat",
        pathMkfifo    = "mkfifo",
        pathPkill     = "pkill",
        env           = {},
        args          = {},
        -- showDebugOutput = true,
        -- trace = true,
    }
}
