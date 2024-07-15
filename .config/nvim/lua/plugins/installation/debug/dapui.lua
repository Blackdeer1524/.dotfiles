local M = {}

M.setup = function()
	local dapui = require("dapui")
	---@diagnostic disable-next-line: missing-fields
	dapui.setup({
		layouts = {
			{
				elements = {
					{
						id = "stacks",
						size = 0.15,
					},
					{
						id = "scopes",
						size = 0.55,
					},
					{
						id = "watches",
						size = 0.30,
					},
				},
				position = "left",
				size = 50,
			},
			{
				elements = {
					{
						id = "console",
						size = 0.5,
					},
					{
						id = "repl",
						size = 0.5,
					},
				},
				position = "bottom",
				size = 10,
			},
		},
	})

	local function on_open()
		dapui.open()
		vim.cmd("NvimTreeClose")
	end

	local dap = require("dap")

	dap.listeners.before.attach.dapui_config = on_open
	dap.listeners.before.launch.dapui_config = on_open
	dap.listeners.before.event_terminated.dapui_config = dapui.close
	dap.listeners.before.event_exited.dapui_config = dapui.close
end

return M
