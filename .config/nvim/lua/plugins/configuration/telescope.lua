-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`

local telescope = require("telescope")
telescope.setup {
    extensions = {
        helpgrep = {
            ignore_paths = {
                vim.fn.stdpath("state") .. "/lazy/readme",
            },
        },
        egrepify = {
            AND = false
        },
        ast_grep = {
            command = {
                "sg",
                "--json=stream",
            },                       -- must have --json=stream
            grep_open_files = false, -- search in opened files
            lang = nil,              -- string value, specify language for ast-grep `nil` for default
        }
    },
}

-- that fixes nvim-ufo (folding plugin)
vim.cmd "autocmd User TelescopePreviewerLoaded setlocal number"

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
require("telescope").load_extension('harpoon')
require('telescope').load_extension('dap')
require('telescope').load_extension('helpgrep')
require('telescope').load_extension('ast_grep')
require "telescope".load_extension("egrepify")
