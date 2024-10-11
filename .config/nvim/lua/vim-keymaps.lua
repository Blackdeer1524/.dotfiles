vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = { noremap = true, silent = true }

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

if vim.g.vscode == nil then
	vim.keymap.set("i", "jk", "<ESC>", opts)
	vim.keymap.set("i", "JK", "<ESC>", opts)

	vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
	vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
	vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
	vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

	vim.keymap.set("n", "<leader>|", "<c-w>v", { desc = "Vertical split" })
	vim.keymap.set("n", "<leader>\\", "<c-w>s", { desc = "Horizontal split" })
end

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Vertical moves
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Not moving cursor
vim.cmd("nnoremap <expr> <C-d> (winheight(0) * 2 / 5) . '<C-d>zz'")
vim.cmd("nnoremap <expr> <C-u> (winheight(0) * 2 / 5) . '<C-u>zz'")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("v", "p", '"_dP', opts)

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

vim.keymap.set("n", "[q", "<cmd>cp<cr>", { desc = "previous quickfix list item" })
vim.keymap.set("n", "]q", "<cmd>cn<cr>", { desc = "next quickfix list item" })

-- local hlstate = vim.o.hlsearch
-- vim.keymap.set({ 'n', 'v' }, "<C-i>", function()
--     hlstate = not hlstate
--     vim.o.hlsearch = hlstate
-- end, { desc = "Toggle hlsearch" })

-- vim.keymap.set({ "n", "v" }, "<C-q>", vim.cmd.nohlsearch, { desc = "Toggle hlsearch" })
