local M = {
    'tpope/vim-fugitive',
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, { expr = true })

                map('n', '[c', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, { expr = true })

                -- Actions
                map('n', '<leader>Hs', gs.stage_hunk, { desc = "[H]unk [s]tage" })
                map('n', '<leader>Hr', gs.reset_hunk, { desc = "[H]unk [r]eset" })
                map('v', '<leader>Hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                    { desc = "[H]unk [s]tage (visual)" })
                map('v', '<leader>Hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                    { desc = "[H]unk [r]eset (visual)" })
                map('n', '<leader>HS', gs.stage_buffer, { desc = "[H]unk [S]tage (Buffer)" })
                map('n', '<leader>Hu', gs.undo_stage_hunk, { desc = "[H]unk stage [u]ndo" })
                map('n', '<leader>HR', gs.reset_buffer, { desc = "[H]unk [R]eset (Buffer)" })
                map('n', '<leader>Hp', gs.preview_hunk, { desc = "[H]unk [p]review" })
                map('n', '<leader>Hb', function() gs.blame_line { full = true } end, { desc = "[H]unk [b]lame" })
                map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = "[t]oggle current line [b]lame" })
                map('n', '<leader>Hd', gs.diffthis, { desc = "[H]unk [d]iffthis" })
                map('n', '<leader>HD', function() gs.diffthis('~') end, { desc = "[H]unk [D]iffthis (~)" })
                map('n', '<leader>td', gs.toggle_deleted, { desc = "[t]oggle [d]eleted" })

                -- Text object
                map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Gitsigns select_hunk" })
            end
        },
    },
    {
        "moyiz/git-dev.nvim",
        dependencies = "ejrichards/baredot.nvim",
        event = "VeryLazy",
        config = function()
            require("git-dev").setup()

            vim.api.nvim_create_user_command("GitDevOpen", function(cmd_args)
                if vim.env.GIT_WORK_TREE ~= nil then
                    require("baredot").toggle()
                end

                -- original git-dev.nvim command
                local repo, ref, cmd_opts = unpack(cmd_args.fargs)
                if ref then
                    ref = load("return " .. ref)()
                end
                if cmd_opts then
                    cmd_opts = load("return " .. cmd_opts)()
                end
                require("git-dev").open(repo, ref, cmd_opts)
                -- end

                if vim.env.GIT_WORK_TREE == nil then
                    require("baredot").toggle()
                end
            end, {
                desc = "Open a git repository.",
                nargs = "*",
            })
        end,
    },
    {
        "ejrichards/baredot.nvim",
        config = function()
            require("baredot").setup {
                git_dir = "~/.cfg",
                disable_pattern = "%.git",
            }
        end
    },
}

return M
