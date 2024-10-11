local M = {
	{
		"vinnymeller/swagger-preview.nvim",
		event = "VeryLazy",
		build = "npm install -g swagger-ui-watcher",
		opts = { port = 8800, host = "localhost" },
	},
	{
		"oysandvik94/curl.nvim",
		event = "VeryLazy",
		cmd = { "CurlOpen" },
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = true,
	},
	{
		-- a plugin for creating tests
		"xeluxee/competitest.nvim",
		lazy = true,
		dependencies = "MunifTanjim/nui.nvim",
		opts = {
			running_directory = ".",
			testcases_directory = "./txt_tests",
			evaluate_template_modifiers = true,
			compile_command = {
				c = { exec = "gcc", args = { "-g", "-Wall", "$(FNAME)", "-o", "$(FNOEXT)" } },
				cpp = { exec = "g++", args = { "-g", "-Wall", "$(FNAME)", "-o", "$(FNOEXT)" } },
				go = { exec = "go", args = { "build", "-o", "main", "$(FNAME)" } },
			},
			run_command = {
				c = { exec = "./$(FNOEXT)" },
				cpp = { exec = "./$(FNOEXT)" },
				go = { exec = "./main" },
				python = { exec = "python", args = { "$(FNAME)" } },
			},
			template_file = os.getenv("HOME") .. "/competitest_tmpls/tmpl.$(FEXT)",
			runner_ui = {
				interface = "split",
			},
		},
	},
	{
		"nvim-neotest/neotest",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",

			"nvim-neotest/neotest-plenary",
			"nvim-neotest/neotest-vim-test",

			"nvim-neotest/nvim-nio",

			{
				"fredrikaverpil/neotest-golang",
				dependencies = {
					{
						"leoluz/nvim-dap-go",
						opts = {},
					},
				},
				branch = "main",
			},
			"rouge8/neotest-rust",
			"nvim-neotest/neotest-python",
		},
		opts = function(_, opts)
			opts.consumers = vim.tbl_extend("force", opts.consumers or {}, {
				overseer = require("neotest.consumers.overseer"),
			})

			opts.adapters = opts.adapters or {}
			opts.adapters["neotest-rust"] = {
				args = { "--no-capture" },
				dap_adapter = "codelldb",
			}
			opts.adapters["neotest-python"] = {}
			opts.adapters["neotest-golang"] = {
				go_test_args = {
					"-v",
					"-race",
					"-count=1",
					"-timeout=60s",
					"-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
				},
				dap_go_enabled = true,
			}
		end,
		config = function(_, opts)
			if opts.adapters then
				local adapters = {}
				for name, config in pairs(opts.adapters or {}) do
					if type(name) == "number" then
						if type(config) == "string" then
							config = require(config)
						end
						adapters[#adapters + 1] = config
					elseif config ~= false then
						local adapter = require(name)
						if type(config) == "table" and not vim.tbl_isempty(config) then
							local meta = getmetatable(adapter)
							if adapter.setup then
								adapter.setup(config)
							elseif meta and meta.__call then
								adapter(config)
							else
								error("Adapter " .. name .. " does not support setup")
							end
						end
						adapters[#adapters + 1] = adapter
					end
				end
				opts.adapters = adapters
			end

			require("neotest").setup(opts)
		end,
		keys = {
			{
				"<leader>na",
				function()
					require("neotest").run.attach()
				end,
				desc = "[n]eotest [a]ttach",
			},
			{
				"<leader>nf",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "[n]eotest run [f]ile",
			},
			{
				"<leader>nA",
				function()
					require("neotest").run.run(vim.uv.cwd())
				end,
				desc = "[n]eotest [A]ll files",
			},
			{
				"<leader>nS",
				function()
					require("neotest").run.run({ suite = true })
				end,
				desc = "[n]eotest [S]uite",
			},
			{
				"<leader>nn",
				function()
					require("neotest").run.run()
				end,
				desc = "[n]eotest [n]earest",
			},
			{
				"<leader>nl",
				function()
					require("neotest").run.run_last()
				end,
				desc = "[n]eotest [l]ast",
			},
			{
				"<leader>ns",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "[n]eotest [s]ummary",
			},
			{
				"<leader>no",
				function()
					require("neotest").output.open({ enter = true, auto_close = true })
				end,
				desc = "[n]eotest [o]utput",
			},
			{
				"<leader>nO",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "[n]eotest [O]utput panel",
			},
			{
				"<leader>nt",
				function()
					require("neotest").run.stop()
				end,
				desc = "[n]eotest [t]erminate",
			},
			{
				"<leader>nd",
				function()
					require("neotest").run.run({ suite = false, strategy = "dap" })
				end,
				desc = "[n]eotest [d]ebug nearest test",
			},
		},
	},
	{
		"stevearc/overseer.nvim",
		opts = {
			dap = false, -- dap is turned in separate file
			templates = { "builtin", "user.launch_delve" },
			task_list = {
				max_width = 0.99,
				min_width = 0.0,
				width = 0.3,
				direction = "right",

				bindings = {
					["<C-v>"] = false,
					["<C-|>"] = "OpenVsplit",
					["<C-s>"] = false,
					["<C-\\>"] = "OpenSplit",

					["<C-k>"] = false,
					["<C-j>"] = false,
					["<C-l>"] = false,
					["<C-h>"] = false,
				},
			},
		},
	},
	{
		-- perf annotations
		"t-troebst/perfanno.nvim",
		event = "VeryLazy",
		config = function()
			local perfanno = require("perfanno")
			local util = require("perfanno.util")

			-- local bgcolor = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg", "gui")
			perfanno.setup({
				-- line_highlights = util.make_bg_highlights(bgcolor, "#504ECD", 10),
				vt_highlight = util.make_fg_highlight("#504ECD"),
			})
		end,
	},
	{
		"stevearc/dressing.nvim",
		opts = {
			select = {
				get_config = function()
					if vim.api.nvim_buf_get_option(0, "filetype") == "idris2" then
						return { enabled = false }
					end
				end,
			},
		},
	},
	{
		"glacambre/firenvim",
		-- Lazy load firenvim
		-- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
		lazy = not vim.g.started_by_firenvim,
		build = function()
			vim.fn["firenvim#install"](0)
		end,
	},
	{
		"LunarVim/bigfile.nvim",
		opts = {
			filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closest MiB
			pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
			features = { -- features to disable
				"indent_blankline",
				"illuminate",
				"lsp",
				"treesitter",
				"syntax",
				"matchparen",
				"vimopts",
				"filetype",
			},
		},
	},
	{
		"NMAC427/guess-indent.nvim",
		opts = {},
	},
	{
		"mistricky/codesnap.nvim",
		build = "make",
		opts = {
			mac_window_bar = false,
			title = "",
			code_font_family = "CaskaydiaCove Nerd Font",
			watermark_font_family = "Pacifico",
			watermark = "",
			bg_theme = "default",
			breadcrumbs_separator = "/",
			has_breadcrumbs = false,
			has_line_number = true,
		},
	},
	{
		"jsongerber/thanks.nvim",
		opts = {
			plugin_manager = "lazy",
		},
		commit = "6ab4a52",
		enabled = false,
	},
	{
		"OXY2DEV/helpview.nvim",
		lazy = false, -- Recommended

		-- In case you still want to lazy load
		-- ft = "help",

		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
}

return M
