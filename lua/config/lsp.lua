local util = require('config.util')

if not vim.lsp.enable then
    return
end

vim.diagnostic.config({
    virtual_text = {}
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        util.keymap('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf })
        util.keymap('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
        util.keymap('n', '<space>rn', vim.lsp.buf.rename, { buffer = args.buf })
        util.keymap('i', '<c-space>', '<c-x><c-o>', { buffer = args.buf })

        util.keymap('i', '<tab>', function()
                if vim.fn.pumvisible() == 1 then
                    return '<c-y>'
                else
                    return '<tab>'
                end
            end,
            { buffer = args.buf, expr = true }
        )

        util.keymap('i', '<cr>', function()
                if vim.fn.pumvisible() == 1 then
                    return '<c-e><cr>'
                else
                    return '<cr>'
                end
            end,
            { buffer = args.buf, expr = true }
        )

        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
            if client:supports_method('textDocument/completion') then
                vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
            end
        end

        vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = args.buf,
            callback = function() vim.lsp.buf.format() end
        })
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

local function config_lsp(config)
    local program_name = config.cmd[1]
    if util.has_executable(program_name) then
        vim.lsp.config(program_name, config)
        vim.lsp.enable(program_name)
    end
end

-- c/c++

local clangd_cmd = { 'clangd', '--background-index' }
if util.is_windows() then
    table.insert(clangd_cmd, '--header-insertion=never')
end

config_lsp({
    cmd = clangd_cmd,
    filetypes = { 'cpp', 'c' },
    root_markers = {
        '.clang-format',
        '.clang-tidy',
        '.clangd',
        'compile_commands.json',
        'compile_flags.txt',
    },
    handlers = {
        ['textDocument/publishDiagnostics'] = function() end,
    },
})

-- go

config_lsp({
    cmd = { 'gopls' },
    filetypes = { 'go' },
    root_markers = { 'go.mod' },
})

-- python

config_lsp({
    cmd = { 'jedi-language-server' },
    filetypes = { 'python' },
    root_markers = {
        'Pipfile',
        'pyproject.toml',
        'requirements.txt',
        'setup.cfg',
        'setup.py',
    },
})

-- lua

vim.env.PATH = vim.env.PATH .. ':' .. vim.fn.stdpath('config') .. '/lls/bin'

config_lsp({
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = {
        '.luacheckrc',
        '.luarc.json',
        '.luarc.jsonc',
        '.stylua.toml',
        'selene.toml',
        'selene.yml',
        'stylua.toml',
    },
    settings = {
        Lua = {
            runtime = {
                path = { 'lua/?.lua', 'lua/?/init.lua' },
                version = 'LuaJIT',
            },
            telemetry = {
                enable = false,
            },
            workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file('', true),
            },
        },
    },
})
