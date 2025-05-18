if not vim.lsp.enable then
    return
end

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local opts = { buffer = args.buf }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)

        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
            if client:supports_method('textDocument/completion') then
                vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger=true})
            end
        end
    end,
})

vim.lsp.config('*', {
    root_markers = { '.git' },
    capabilities = {
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = false,
                },
            },
        },
    },
})

vim.lsp.config('clangd', {
    cmd = {'clangd', '--background-index', '--header-insertion=never'},
    filetypes = {'cpp', 'c'},
    root_markers = {'compile_commands.json'},
})

vim.lsp.config('gopls', {
    cmd = {'gopls'},
    filetypes = {'go'},
    root_markers = {'go.mod'},
})

vim.lsp.config('jedi-language-server', {
    cmd = {'jedi-language-server'},
    filetypes = {'python'},
})

vim.env.PATH = vim.env.PATH .. ':' .. vim.fn.stdpath('config') .. '/lls/bin'
local runtime_path = vim.split(package.path, ';', {})
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

vim.lsp.config('lua-language-server', {
    cmd = {'lua-language-server'},
    filetypes = {'lua'},
    root_markers = {'.luarc.json', '.luarc.jsonc'},
    settings = {
        Lua = {
            diagnostics = {
                globals = {'vim'},
                disable = {'param-type-mismatch', 'undefined-field'},
            },
            runtime = {
                path = runtime_path,
                version = 'LuaJIT',
            },
            telemetry = {
                enable = false,
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                },
            },
        },
    },
})

vim.lsp.enable({
    'clangd',
    'gopls',
    'jedi-language-server',
    'lua-language-server',
})
