require("dap-python").setup(require("lsp.defaults").MASON_PACKAGES .. "/debugpy/venv/bin/python")
require("dap-python").resolve_python = function()
	return "/usr/bin/python"
end
