-- [[ Setting options ]]
-- See `:help vim.o`

vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.o.showtabline = 1

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.o.updatetime = 50

vim.o.laststatus = 3

-- highlights cursor line
vim.opt.cursorline = true

-- Set highlight on search
vim.o.hlsearch = true
vim.o.incsearch = true

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- vim.o.colorcolumn = 80
-- vim.api.nvim_set_option_value("colorcolumn", "80", {})

-- Limit the maximum number of items to show in the popup menu
vim.o.pumheight = 20

vim.o.splitright = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

vim.o.sidescrolloff = 15
vim.o.scrolloff = 7
vim.o.wrap = true

vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.smarttab = false
vim.o.smartindent = true
vim.o.expandtab = false

vim.cmd([[autocmd FileType html setlocal shiftwidth=2 softtabstop=2]])
vim.cmd([[autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2]])
vim.cmd([[autocmd FileType template setlocal shiftwidth=2 softtabstop=2]])

-- Enable break indent
vim.o.breakindent = false

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes:2"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- vim.g.code_action_menu_show_details = false
-- vim.g.code_action_menu_show_diff = false

-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "Makefile" },
	callback = function(_)
		vim.opt_local.expandtab = false
	end,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
