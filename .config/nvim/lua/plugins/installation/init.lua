return vim.tbl_extend(
	"force",
	{
		require("plugins/installation/debug"),
	},
	require("plugins/installation/themes"),
	require("plugins/installation/visuals"),
	require("plugins/installation/editor"),
	require("plugins/installation/lsp"),
	require("plugins/installation/treesitter"),
	require("plugins/installation/navigations"),
	require("plugins/installation/git"),
	require("plugins/installation/other"),
	require("plugins/installation/utils")
)
