vim.keymap.set("n", "[n", function() require("neotest").jump.prev({ status = "failed" }) end,
    { desc = "Neotest prev failed" })
vim.keymap.set("n", "]n", function() require("neotest").jump.next({ status = "failed" }) end,
    { desc = "veotest next failed" })

vim.keymap.set("n", "<leader>nk", function() require("neotest").run.stop() end,
    { desc = "[n]eotest [k]ill (stop running)" })

vim.keymap.set("n", "<leader>nra", function() require("neotest").run.run(vim.fn.expand("%")) end,
    { desc = "[n]eotest [r]un [a]ll" })
vim.keymap.set("n", "<leader>nrt", function() require("neotest").run.run() end,
    { desc = "[n]eotest [r]un [t]his (nearest)" })
vim.keymap.set("n", "<leader>nrr", function() require("neotest").run.run_last() end,
    { desc = "[n]eotest [r]e[r]un" })

vim.keymap.set("n", "<leader>nda", function() require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" }) end,
    { desc = "[n]eotest [d]ebug [a]ll" })
vim.keymap.set("n", "<leader>ndt", function() require("neotest").run.run({ strategy = "dap" }) end,
    { desc = "[n]eotest [d]ebug [t]his (neareas)" })
vim.keymap.set("n", "<leader>ndl", function() require("neotest").run.run_last({ strategy = "dap" }) end,
    { desc = "[n]eotest [r]e[r]un" })

vim.keymap.set("n", "<leader>ns", function() require("neotest").summary.toggle() end, { desc = "[n]eotest [s]ummary" })

vim.keymap.set("n", "<leader>np", function()
        require("neotest").output_panel.clear()
        require("neotest").output_panel.toggle()
    end,
    { desc = "[n]eotest output [p]anel" })

vim.keymap.set("n", "<leader>no", function() require("neotest").output.open({ enter = true }) end,
    { desc = "[n]eotest [o]utput" })
