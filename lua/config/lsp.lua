local util = require('config.util')

if not vim.lsp.enable then
    return
end

vim.diagnostic.config({
    virtual_text = {}
})

local lsp_attach_group = vim.api.nvim_create_augroup('lsp_attach', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
    group = lsp_attach_group,
    callback = function(args)
        util.keymap('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf })
        util.keymap('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
        util.keymap('n', '<leader>rn', vim.lsp.buf.rename, { buffer = args.buf })
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

        if util.is_linux() and client and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('lsp_format_' .. args.buf, { clear = true }),
                buffer = args.buf,
                callback = function()
                    -- vim-go handles formatting and import organization together.
                    if vim.bo[args.buf].filetype == 'go' and vim.g.go_loaded_install == 1 then
                        return
                    end
                    if not vim.lsp.buf_is_attached(args.buf, client.id) then
                        return
                    end
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                end,
                desc = 'Format with the attached language server',
            })
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

local function config_lsp(config)
    local program_name = config.cmd[1]
    if util.has_executable(program_name) then
        -- Per-server lists replace the wildcard list; retain the Git fallback.
        table.insert(config.root_markers, '.git')
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
    root_markers = { 'go.work', 'go.mod' },
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

local path_separator = util.is_windows() and ';' or ':'
vim.env.PATH = (vim.env.PATH or '') .. path_separator .. vim.fn.stdpath('config') .. '/lls/bin'

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
