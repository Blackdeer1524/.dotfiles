local opts = { noremap = true, silent = true }

-- local term_opts = {silent = true}

local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("i", "jk", "<ESC>", opts)

keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Vertical moves
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Not moving cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- keymap("v", "<A-j>", ":m +1<CR>==", opts)
-- keymap("v", "<A-h>", ":m -2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

vim.keymap.set('n',
    '<leader>e',
    vim.cmd.NvimTreeFocus,
    { desc = "Focus nvim tree" })

keymap("n", "<leader>e", ":NvimTreeFocus<CR>", { noremap = true, silent = true })
keymap("n", "<leader>r", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
keymap("n", "<C-c>", ":w<CR>:bd<CR>", { noremap = true, silent = true })
keymap("n", "<leader>p", "<C-w><C-p>", { noremap = true, silent = true })

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

keymap("n", "<leader>f", ":Format<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
