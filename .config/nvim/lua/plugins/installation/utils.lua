local M = {
	{
		-- autosave events
		"Pocco81/auto-save.nvim",
		config = function()
			require("auto-save").setup({
				trigger_events = { "InsertLeave", "BufLeave" },
				condition = function(buf)
					local fn = vim.fn
					local utils = require("auto-save.utils.data")

					local status, buf_name = pcall(vim.api.nvim_buf_get_name, buf)
					if not status then
						return false
					end

					if string.find(buf_name, "harpoon") or string.find(buf_name, "Overseer") then
						return false
					end
					-- vim.notify(buf_name)

					local oil_protocol = string.sub(buf_name, 1, 6)
					if
						fn.getbufvar(buf, "&modifiable") == 1
						and utils.not_in(fn.getbufvar(buf, "&filetype"), {})
						and oil_protocol ~= "oil://"
					then
						return true -- met condition(s), can save
					end
					return false -- can't save
				end,
			})
		end,
	},
	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		branch = "v0.6", --recommended as each new version will have breaking changes
		opts = {
			--Config goes here
		},
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	-- Useful plugin to show you pending keybinds.
	{
		"folke/which-key.nvim",
		enabled = true,
		dependencies = { "Wansmer/langmapper.nvim" },
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300

			local lmu = require("langmapper.utils")
			local view = require("which-key.view")
			local execute = view.execute

			-- wrap `execute()` and translate sequence back
			view.execute = function(prefix_i, mode, buf)
				-- Translate back to English characters
				prefix_i = lmu.translate_keycode(prefix_i, "default", "ru")
				execute(prefix_i, mode, buf)
			end

			-- If you want to see translated operators, text objects and motions in
			-- which-key prompt
			local presets = require("which-key.plugins.presets")
			presets.operators = lmu.trans_dict(presets.operators)
			presets.objects = lmu.trans_dict(presets.objects)
			presets.motions = lmu.trans_dict(presets.motions)
			-- etc

			require("which-key").setup()
		end,
	},
	-- quick test suits
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"dfendr/clipboard-image.nvim",
		opts = {},
	},
}

return M
