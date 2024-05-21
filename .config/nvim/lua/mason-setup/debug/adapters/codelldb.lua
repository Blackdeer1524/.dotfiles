local dap = require("dap")
dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = require("lsp.defaults").MASON_BIN .. "/codelldb",
		args = { "--port", "${port}" },
		-- On windows you may have to uncomment this:
		-- detached = false,
	},
}
