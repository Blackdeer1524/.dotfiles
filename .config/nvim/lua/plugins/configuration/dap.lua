if vim.g.vscode ~= nil then
	return
end

require("dap.ext.vscode").json_decode = require("overseer.json").decode
require("overseer").patch_dap(true)

vim.api.nvim_create_user_command("DapLoadLaunchJSON", function()
	require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "c", "cpp" } })
end, { nargs = 0 })

vim.api.nvim_create_autocmd({ "VimEnter" }, {
	callback = function()
		vim.cmd("DapLoadLaunchJSON")
	end,
})
local dap = require("dap")
local persisten_breakpoints = require("persistent-breakpoints.api")

vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<F1>", dap.step_into)
vim.keymap.set("n", "<F2>", dap.step_over)
vim.keymap.set("n", "<F3>", dap.step_out)
vim.keymap.set("n", "<F4>", dap.step_back)

require("which-key").add({
	{
		mode = "n",
		{ "<leader>d", group = "[d]ap" },
		{ "<leader>db", persisten_breakpoints.toggle_breakpoint, desc = "[b]reak point", noremap = true },
		{
			"<leader>dB",
			persisten_breakpoints.set_conditional_breakpoint,
			desc = "conditional [b]reakpoint",
			noremap = true,
		},
		{
			"<leader>dl",
			persisten_breakpoints.set_log_point,
			desc = "[l]og point",
			noremap = true,
		},
		{ "<leader>dr", dap.run_last, desc = "[r]erun", noremap = true },
		{ "<leader>df", dap.focus_frame, desc = "[f]ocus frame", noremap = true },
		{ "<leader>dc", dap.run_to_cursor, desc = "run [t]o cursor", noremap = true },
		{ "<leader>du", dap.up, desc = "[u]p", noremap = true },
		{ "<leader>dd", dap.down, desc = "[d]own", noremap = true },
		{ "<leader>dt", require("dapui").toggle, desc = "[t]oggle ui" },
		{
			"<leader>dT",
			function()
				require("dap.ui.widgets").centered_float(require("dap.ui.widgets").threads)
			end,
			desc = "show [T]hreads",
		},
		{
			"<leader>dC",
			require("persistent-breakpoints.api").clear_all_breakpoints,
			desc = "[C]lear all breakpoints",
			noremap = true,
		},
		{ "<leader>dL", "<cmd>Telescope dap list_breakpoints<cr>", desc = "[l]ist breakpoints", noremap = true },
		{ "<leader>dK", "<cmd>DapTerminate<cr>", desc = "[K]ill", noremap = true },
		{ "<leader>dh", require("dap.ui.widgets").hover, desc = "[h]over", noremap = true },
	},
})

-- https://github.com/mfussenegger/nvim-dap/discussions/355

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
	pattern = "*",
	desc = "Prevent colorscheme clearing self-defined DAP marker colors",
	callback = function()
		-- Reuse current SignColumn background (except for DapStoppedLine)
		local sign_column_hl = vim.api.nvim_get_hl(0, { name = "SignColumn" })
		-- if bg or ctermbg aren't found, use bg = 'bg' (which means current Normal) and ctermbg = 'Black'
		-- convert to 6 digit hex value starting with #
		local sign_column_bg = (sign_column_hl.bg ~= nil) and ("#%06x"):format(sign_column_hl.bg) or "bg"

		vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379", bg = sign_column_bg })
		vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#2e4d3d" })
		vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#993939", bg = sign_column_bg })
		vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#888ca6", bg = sign_column_bg })
		vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef", bg = sign_column_bg })
	end,
})

-- reload current color scheme to pick up colors override if it was set up in a lazy plugin definition fashion
vim.cmd.colorscheme(vim.g.colors_name)

vim.fn.sign_define("DapBreakpoint", {
	text = "",
	texthl = "DapBreakpoint",
	numhl = "DapBreakpoint",
})
vim.fn.sign_define("DapBreakpointCondition", {
	text = "",
	texthl = "DapBreakpoint",
	numhl = "DapBreakpoint",
})
vim.fn.sign_define("DapBreakpointRejected", {
	text = "",
	texthl = "DapBreakpointRejected",
	numhl = "DapBreakpointRejected",
})
vim.fn.sign_define("DapLogPoint", {
	text = "",
	texthl = "DapLogPoint",
	numhl = "DapLogPoint",
})
vim.fn.sign_define("DapStopped", {
	text = "",
	texthl = "DapStopped",
	numhl = "DapStopped",
})
