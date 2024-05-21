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

vim.keymap.set("n", "<leader>dr", dap.run_last, { desc = "[d]ap [r]erun", noremap = true })
vim.keymap.set("n", "<leader>df", dap.focus_frame, { desc = "[d]ap [f]ocus frame", noremap = true })

vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<F1>", dap.step_into)
vim.keymap.set("n", "<F2>", dap.step_over)
vim.keymap.set("n", "<F3>", dap.step_out)
vim.keymap.set("n", "<F4>", dap.step_back)
vim.keymap.set("n", "<leader>dc", dap.run_to_cursor, { desc = "[d]ebug run [t]o cursor", noremap = true })
vim.keymap.set("n", "<leader>du", dap.up, { desc = "[d]ebug [u]p", noremap = true })
vim.keymap.set("n", "<leader>dd", dap.down, { desc = "[d]ebug [d]own", noremap = true })
vim.keymap.set(
	"n",
	"<leader>db",
	persisten_breakpoints.toggle_breakpoint,
	{ desc = "[d]ebug [b]reak point", noremap = true }
)
vim.keymap.set(
	"n",
	"<leader>dB",
	persisten_breakpoints.set_conditional_breakpoint,
	{ desc = "[d]ebug conditional [b]reakpoint", noremap = true }
)
vim.keymap.set(
	"n",
	"<leader>dC",
	require("persistent-breakpoints.api").clear_all_breakpoints,
	{ desc = "[d]ebug [C]lear all breakpoints", noremap = true }
)
vim.keymap.set(
	"n",
	"<leader>dl",
	"<cmd>Telescope dap list_breakpoints<cr>",
	{ desc = "[d]ebug [l]ist breakpoints", noremap = true }
)
vim.keymap.set("n", "<leader>dK", "<cmd>DapTerminate<cr>", { desc = "[d]ebug [K]ill", noremap = true })
vim.keymap.set("n", "<leader>dh", require("dap.ui.widgets").hover, { desc = "[d]ap [h]over", noremap = true })

-- https://github.com/mfussenegger/nvim-dap/discussions/355
vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

vim.fn.sign_define("DapBreakpoint", {
	text = "",
	texthl = "DapBreakpoint", --[[ linehl = 'DapBreakpoint', ]]
	numhl = "DapBreakpoint",
})
vim.fn.sign_define("DapBreakpointCondition", {
	text = "",
	texthl = "DapBreakpoint", --[[ linehl = 'DapBreakpoint', ]]
	numhl = "DapBreakpoint",
})
vim.fn.sign_define("DapBreakpointRejected", {
	text = "",
	texthl = "DapBreakpoint", --[[ linehl = 'DapBreakpoint', ]]
	numhl = "DapBreakpoint",
})
vim.fn.sign_define("DapLogPoint", {
	text = "",
	texthl = "DapLogPoint",
	--[[ linehl = 'DapLogPoint', ]]
	numhl = "DapLogPoint",
})

-- local dap = require('dap')
-- dap.listeners.before.event_initialized["debug-indicate-start"] = function(session, body)
--     vim.notify('Session started', 4)
-- end
--
-- dap.listeners.before.event_exited["debug-indicate-exit"] = function(session, body)
--     vim.notify('Session terminated', 2)
-- end

vim.fn.sign_define("DapStopped", {
	text = "",
	texthl = "DapStopped", --[[ linehl = 'DapStopped', ]]
	numhl = "DapStopped",
})
