local util = require('config.util')

if not vim.lsp.enable then
    return
end

vim.diagnostic.config()

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local keymap_opts = { buffer = args.buf }
        util.keymap('n', 'gd', vim.lsp.buf.definition, keymap_opts)
        util.keymap('n', 'K', vim.lsp.buf.hover, keymap_opts)
        util.keymap('n', '<space>rn', vim.lsp.buf.rename, keymap_opts)

        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
            if client:supports_method('textDocument/completion') then
                vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
            end
        end

        if vim.fn.has('win32') == 0 then
            vim.api.nvim_create_autocmd('BufWritePre', {
                buffer = args.buf,
                callback = function() vim.lsp.buf.format() end
            })
        end
    end,
})

util.keymap('i', '<tab>', function()
        if vim.fn.pumvisible() == 1 then
            return '<c-y>'
        else
            return '<tab>'
        end
    end,
    { expr = true }
)

util.keymap('i', '<cr>', function()
        if vim.fn.pumvisible() == 1 then
            return '<c-e><cr>'
        else
            return '<cr>'
        end
    end,
    { expr = true }
)

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
    if vim.fn.executable(program_name) == 1 then
        vim.lsp.config(program_name, config)
        vim.lsp.enable(program_name)
    end
end

-- c/c++

local clangd_cmd = { 'clangd', '--background-index' }
if vim.fn.has('win32') == 1 then
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

local runtime_path = vim.split(package.path, ';', {})
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

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
            diagnostics = {
                globals = { 'vim' },
                disable = { 'param-type-mismatch', 'undefined-field' },
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
