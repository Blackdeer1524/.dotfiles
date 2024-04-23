local M = {}


M.on_attach = function(client, bufnr, is_tsserver)
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    if client.server_capabilities.codeLensProvider ~= nil and client.server_capabilities.codeLensProvider ~= false then
        vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
            callback = function(ev)
                vim.lsp.codelens.refresh()
            end,
            buffer = bufnr,
        })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>cl', vim.lsp.codelens.run, 'select [C]ode[L]ens')

    local telescope_search_layout =
    {
        -- sorting_strategy = "ascending",
        -- layout_strategy = "flex",
        -- layout_config = {
        --     flip_columns = 200,
        --     vertical = { height = 0.9, preview_height = 0.5, prompt_position = 'bottom' },
        --     horizontal = { prompt_position = 'top', },
        -- },
        -- mappings = { i = { ['<C-u>'] = false, ['<C-d>'] = false, }, },
        sorting_strategy = "ascending",
        layout_strategy = "vertical",
        mappings = { i = { ['<C-u>'] = false, ['<C-d>'] = false, }, },
    }

    nmap('gd', function() require('telescope.builtin').lsp_definitions(telescope_search_layout) end,
        '[G]oto [D]efinition')
    nmap('gr', function() require('telescope.builtin').lsp_references(telescope_search_layout) end,
        '[G]oto [R]eferences')
    nmap('gI', function() require('telescope.builtin').lsp_implementations(telescope_search_layout) end,
        '[G]oto [I]mplementation')

    nmap('<leader>oc', function() require('telescope.builtin').lsp_outgoing_calls(telescope_search_layout) end,
        'LSP [o]utgoing [c]alls')
    nmap('<leader>ic', function() require('telescope.builtin').lsp_incoming_calls(telescope_search_layout) end,
        'LSP incoming [c]alls')

    nmap('<leader>D', function() require('telescope.builtin').lsp_type_definitions(telescope_search_layout) end,
        'Type [D]efinition')
    nmap('<leader>ws',
        function() require('telescope.builtin').lsp_dynamic_workspace_symbols(telescope_search_layout) end,
        '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    local show_documentation = function()
        local filetype = vim.bo.filetype
        if vim.tbl_contains({ 'vim', 'help' }, filetype) then
            vim.cmd('h ' .. vim.fn.expand('<cword>'))
        elseif vim.tbl_contains({ 'man' }, filetype) then
            vim.cmd('Man ' .. vim.fn.expand('<cword>'))
        elseif vim.fn.expand('%:t') == 'Cargo.toml' then
            require('crates').show_popup()
        else
            -- vim.lsp.buf.hover()
            require("pretty_hover").hover()
        end
    end

    nmap('K', show_documentation, 'Hover Documentation')
    nmap('<leader>K', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format {}
    end, { desc = 'Format current buffer with LSP' })

    vim.api.nvim_buf_create_user_command(bufnr, 'LongFormat', function(_)
        vim.lsp.buf.format { timeout_ms = 5000 }
    end, { desc = 'Format current buffer with LSP [longer timeout]' })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })

    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(bufnr, true)
    end

    -- require("lsp-inlayhints").on_attach(client, bufnr)
end

M.MASON_PACKAGES = vim.fn.stdpath("data") .. "/mason/packages"
M.MASON_BIN = vim.fn.stdpath("data") .. "/mason/bin"

return M
