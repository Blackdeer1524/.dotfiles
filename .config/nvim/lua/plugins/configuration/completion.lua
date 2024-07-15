-- nvim-cmp setup
local cmp = require("cmp")
local luasnip = require("luasnip")

local lspkind = require("lspkind")
lspkind.init({
	symbol_map = {
		Text = "󰉿",
		Method = "m",
		Function = "󰊕",
		Constructor = "",
		Field = "",
		Variable = "󰫧",
		Class = "",
		Interface = "",
		Module = "",
		Property = "",
		Unit = "",
		Value = "󰎠",
		Enum = "",
		Keyword = "",
		Snippet = "",
		Color = "󰝤",
		File = "󰈙",
		Reference = "",
		Folder = "󰉋",
		EnumMember = "",
		Constant = "󰯱",
		Struct = "",
		Event = "",
		Operator = "",
		TypeParameter = "",
	},
})

vim.filetype.add({
	extension = {
		ev = "proto",
	},
})

luasnip.config.setup({})
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
	sources = {
		{ name = "dap" },
	},
})

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- https://github.com/hrsh7th/nvim-cmp/issues/750
cmp.setup({
	experimental = {
		ghost_text = false,
	},
	completion = {
		autocomplete = false,
	},
	enabled = function()
		return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
	end,
	preselect = cmp.PreselectMode.None,
	---@diagnostic disable-next-line: missing-fields
	formatting = {
		format = require("lspkind").cmp_format({
			mode = "symbol_text", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
			before = require("tailwind-tools.cmp").lspkind_format,
		}),
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete({}),

		["<CR>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				if luasnip.expandable() then
					luasnip.expand()
				else
					cmp.confirm({
						select = true,
					})
				end
			else
				fallback()
			end
		end),

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.expand_or_locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{
			name = "lazydev",
			group_index = 0, -- set group index to 0 to skip loading LuaLS completions
		},
		{ name = "nvim_lsp", max_item_count = 30 },
		{ name = "nvim_lsp_signature_help" },
		{ name = "luasnip" },
		{ name = "crates" },
		{ name = "path" },
		{
			name = "tags",
			option = {
				-- this is the default options, change them if you want.
				-- Delayed time after user input, in milliseconds.
				complete_defer = 100,
				-- Max items when searching `taglist`.
				max_items = 10,
				-- Use exact word match when searching `taglist`, for better searching
				-- performance.
				exact_match = false,
				-- Prioritize searching result for current buffer.
				current_buffer_only = false,
			},
		},
	},
})
