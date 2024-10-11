if vim.g.vscode ~= nil then
	return
end

local overseer = require("overseer")

vim.api.nvim_create_user_command("JsonSort", function(_)
	local current_file = vim.api.nvim_buf_get_name(0)
	local tmp_file_path = "/tmp/tmp.json"

	local task = overseer.new_task({
		name = "Sort Json",
		strategy = {
			"orchestrator",
			tasks = {
				{ "shell", cmd = string.format("jq --sort-keys '.' %s > %s", current_file, tmp_file_path) },
				{ "shell", cmd = string.format("mv %s %s", tmp_file_path, current_file) },
			},
		},
	})
	task:start()
end, { desc = "sort json" })
