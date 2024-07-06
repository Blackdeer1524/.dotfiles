local plugins = {
	{
		"Wansmer/langmapper.nvim",
		lazy = false,
		priority = 1, -- High priority is needed if you will use `autoremap()`
		config = function()
			local function escape(str)
				-- You need to escape these characters to work correctly
				local escape_chars = [[;,."|\]]
				return vim.fn.escape(str, escape_chars)
			end

			-- Recommended to use lua template string
			local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
			local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]
			local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
			local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]

			vim.opt.langmap = vim.fn.join({
				-- | `to` should be first     | `from` should be second
				escape(ru_shift)
					.. ";"
					.. escape(en_shift),
				escape(ru) .. ";" .. escape(en),
			}, ",")

			require("langmapper").setup({
				hack_keymap = true,
			})
		end,
	},
}
vim.list_extend(plugins, { require("plugins/installation/debug") })
vim.list_extend(plugins, require("plugins/installation/lsp"))
vim.list_extend(plugins, require("plugins/installation/themes"))
vim.list_extend(plugins, require("plugins/installation/visuals"))
vim.list_extend(plugins, require("plugins/installation/editor"))
vim.list_extend(plugins, require("plugins/installation/treesitter"))
vim.list_extend(plugins, require("plugins/installation/navigations"))
vim.list_extend(plugins, require("plugins/installation/git"))
vim.list_extend(plugins, require("plugins/installation/other"))
vim.list_extend(plugins, require("plugins/installation/utils"))

return plugins
