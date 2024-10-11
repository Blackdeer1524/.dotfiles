if vim.g.vscode ~= nil then
	return
end

vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
	callback = function(_)
		-- returns (a * c1 + (d - a) * c2) / d
		local function blend(d, a, c1, c2)
			assert(d >= a, "color blending assertion error")

			local function get_color_part(c, shift)
				return bit.rshift(c, shift) % 0x100
			end

			local r = math.floor((a * get_color_part(c1, 16) + (d - a) * get_color_part(c2, 16)) / d)
			local g = math.floor((a * get_color_part(c1, 8) + (d - a) * get_color_part(c2, 8)) / d)
			local b = math.floor((a * get_color_part(c1, 0) + (d - a) * get_color_part(c2, 0)) / d)
			return bit.lshift(r, 16) + bit.lshift(g, 8) + b
		end

		local pmenu_hl = vim.api.nvim_get_hl(0, { name = "PmenuSel" })
		local pmenu_sel_bg = blend(2, 1, pmenu_hl.bg, 0)
		vim.api.nvim_set_hl(0, "PmenuSel", { fg = "NONE", bg = pmenu_sel_bg })

		local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
		local erro_bg = blend(30, 23, normal_hl.bg, 0xE86671)
		local warn_bg = blend(30, 23, normal_hl.bg, 0xFA973A)
		local hint_bg = blend(30, 23, normal_hl.bg, 0x17BE3B)
		local info_bg = blend(30, 23, normal_hl.bg, 0x3770E0)

		vim.api.nvim_set_hl(0, "ErrorMsgLine", { bg = erro_bg, bold = true })
		vim.api.nvim_set_hl(0, "WarningMsgLine", { bg = warn_bg, bold = true })
		vim.api.nvim_set_hl(0, "HintMsgLine", { bg = hint_bg, bold = true })
		vim.api.nvim_set_hl(0, "InfoMsgLine", { bg = info_bg, bold = true })
	end,
})

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
		linehl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsgLine",
			[vim.diagnostic.severity.WARN] = "WarningMsgLine",
			[vim.diagnostic.severity.INFO] = "InfoMsgLine",
			[vim.diagnostic.severity.HINT] = "HintMsgLine",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
	severity_sort = true,
	update_in_insert = false,
	virtual_text = true,
	virtual_lines = false, -- see ErichDonGubler/lsp_lines.nvim
	-- virtual_text = {
	--   severity = vim.diagnostic.severity.WARN,
	--   severity_sort = true,
	-- },
	float = {
		border = "single",
		format = function(diagnostic)
			local code = diagnostic.code
			if not code and diagnostic.user_data ~= nil then
				code = diagnostic.user_data.lsp.code
			end
			local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")

			if diagnostic.source then
				message = string.format(
					"%s (%s)",
					message,
					diagnostic.source:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
				)
			end

			if code then
				message = string.format(
					"%s [%s]",
					message,
					(code .. ""):gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
				)
			end

			return message
		end,
	},
})
