-- Themery block
-- This block will be replaced by Themery.
vim.cmd("colorscheme kanagawa-wave")

vim.api.nvim_set_hl(0, "LineNr", { fg = '#D6AD5C' })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = '#56F3FF', bold=true })
vim.cmd("highlight WinSeparator guifg=#D6AD5C")

vim.g.theme_id = 8
-- end themery block
