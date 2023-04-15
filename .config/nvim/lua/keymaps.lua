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
keymap("i", "JK", "<ESC>", opts)

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

keymap("v", "p", '"_dP', opts)

vim.keymap.set('n', '<leader>e', vim.cmd.NvimTreeFocus, { desc = "Focus nvim tree" })
vim.keymap.set('n', '<leader>tt', vim.cmd.NvimTreeToggle, { desc = "Toggle nvim tree" })

vim.keymap.set('n', '<leader>|', "<c-w>v", { desc = "Vertical split" })
vim.keymap.set('n', '<leader>\\', "<c-w>s", { desc = "Horizontal split" })

keymap("n", "<leader>p", "<C-w><C-p>", { noremap = true, silent = true })

keymap("n", "<leader>f", ":Format<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Navigate buffers
-- keymap("n", "<S-l>", ":bnext<CR>", opts)
-- keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move to previous/next
vim.keymap.set('n', '<S-h>', '<Cmd>BufferPrevious<CR>')
vim.keymap.set('n', '<S-l>', '<Cmd>BufferNext<CR>')
-- Re-order to previous/next
vim.keymap.set('n', '<C-A-h>', '<Cmd>BufferMovePrevious<CR>')
vim.keymap.set('n', '<C-A-l>', '<Cmd>BufferMoveNext<CR>')
-- Goto buffer in position...
vim.keymap.set('n', '<A-1>', '<Cmd>BufferGoto 1<CR>')
vim.keymap.set('n', '<A-2>', '<Cmd>BufferGoto 2<CR>')
vim.keymap.set('n', '<A-3>', '<Cmd>BufferGoto 3<CR>')
vim.keymap.set('n', '<A-4>', '<Cmd>BufferGoto 4<CR>')
vim.keymap.set('n', '<A-5>', '<Cmd>BufferGoto 5<CR>')
vim.keymap.set('n', '<A-6>', '<Cmd>BufferGoto 6<CR>')
vim.keymap.set('n', '<A-7>', '<Cmd>BufferGoto 7<CR>')
vim.keymap.set('n', '<A-8>', '<Cmd>BufferGoto 8<CR>')
vim.keymap.set('n', '<A-9>', '<Cmd>BufferGoto 9<CR>')
vim.keymap.set('n', '<A-0>', '<Cmd>BufferLast<CR>')
-- Pin/unpin buffer
vim.keymap.set('n', '<A-p>', '<Cmd>BufferPin<CR>')
-- Close buffer
vim.keymap.set('n', '<A-c>', '<Cmd>BufferClose<CR>')
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
vim.keymap.set('n', '<C-p>', '<Cmd>BufferPick<CR>')
-- Sort automatically by...
vim.keymap.set('n', '<leader>bb', '<Cmd>BufferOrderByBufferNumber<CR>')
vim.keymap.set('n', '<leader>bd', '<Cmd>BufferOrderByDirectory<CR>')
vim.keymap.set('n', '<leader>bl', '<Cmd>BufferOrderByLanguage<CR>')
vim.keymap.set('n', '<leader>bw', '<Cmd>BufferOrderByWindowNumber<CR>')

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used

-- vs-tasks
vim.keymap.set('n', "<Leader>ta", '<Cmd>lua require("telescope").extensions.vstask.tasks()<CR>', { desc = "T[a]sks" })
vim.keymap.set('n', "<Leader>ti", '<Cmd>lua require("telescope").extensions.vstask.inputs()<CR>',
    { desc = "Tasks [I]nputs" })
vim.keymap.set('n', "<Leader>th", '<Cmd>lua require("telescope").extensions.vstask.history()<CR>',
    { desc = "Tasks [H]istory" })
vim.keymap.set('n', "<Leader>tl", '<Cmd>lua require("telescope").extensions.vstask.launch()<CR>',
    { desc = "Tasks [L]aunch" })

-- nvim-spectre
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").open()<CR>', {
    desc = "Open Spectre"
})
