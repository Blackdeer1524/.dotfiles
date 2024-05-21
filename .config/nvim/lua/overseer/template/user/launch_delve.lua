return {
	name = "launch delve",
	builder = function()
		return {
			cmd = { "dlv", "dap", "-l", "127.0.0.1:38697", "--log", '--log-output="dap"' },
			components = {
				"default",
			},
		}
	end,
	condition = {
		filetype = { "go" },
	},
}
