require("dap").adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = "node",
		args = {
			require("lsp.defaults").MASON_PACKAGES .. "/js-debug-adapter/js-debug/src/dapDebugServer.js",
			"${port}",
		},
	},
}

require("dap").configurations.javascript = {
	{
		type = "pwa-node",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		cwd = "${workspaceFolder}",
	},
}

require("dap").configurations.typescript = {
	{
		type = "pwa-node",
		request = "launch",
		name = "Launch file",
		runtimeExecutable = "deno",
		runtimeArgs = {
			"run",
			"--inspect-wait",
			"--allow-all",
		},
		program = "${file}",
		cwd = "${workspaceFolder}",
		attachSimplePort = 9229,
	},
}
