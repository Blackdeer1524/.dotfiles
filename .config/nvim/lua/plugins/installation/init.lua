local plugins = {}
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
