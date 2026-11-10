local util = require('config.util')

if not vim.lsp.enable then
    return
end

-- Neovim logs every server's stderr at ERROR level, so chatty servers grow lsp.log without bound.
vim.lsp.log.set_level('OFF')

vim.diagnostic.config({
    virtual_text = true,
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
            return vim.fn.pumvisible() == 1 and '<c-y>' or '<tab>'
        end, { buffer = args.buf, expr = true })

        util.keymap('i', '<cr>', function()
            return vim.fn.pumvisible() == 1 and '<c-e><cr>' or '<cr>'
        end, { buffer = args.buf, expr = true })

        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client:supports_method('textDocument/completion') then
            vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end
    end,
})

if util.is_unix() then
    vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('lsp_format', { clear = true }),
        callback = function(args)
            -- vim-go handles formatting and import organization together.
            if vim.bo[args.buf].filetype == 'go' and vim.g.go_loaded_install == 1
                and (vim.g.go_fmt_autosave ~= 0 or vim.g.go_imports_autosave ~= 0) then
                return
            end
            local clients = vim.lsp.get_clients({ bufnr = args.buf, method = 'textDocument/formatting' })
            if clients[1] then
                vim.lsp.buf.format({ bufnr = args.buf, id = clients[1].id })
            end
        end,
        desc = 'Format with an attached language server',
    })
end

vim.lsp.config('*', {
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

local function config_lsp(name, config)
    config.cmd = config.cmd or { name }
    if util.has_executable(config.cmd[1]) then
        table.insert(config.root_markers, '.git')
        vim.lsp.config(name, config)
        vim.lsp.enable(name)
    end
end

-- c/c++

local clangd_cmd = { 'clangd', '--background-index', '--log=error' }
if util.is_windows() then
    table.insert(clangd_cmd, '--header-insertion=never')
end

config_lsp('clangd', {
    cmd = clangd_cmd,
    filetypes = { 'cpp', 'c' },
    root_markers = {
        -- These markers have equal priority: use the nearest matching directory.
        {
            '.clang-format',
            '.clang-tidy',
            '.clangd',
            'compile_commands.json',
            'compile_flags.txt',
        },
    },
    handlers = {
        ['textDocument/publishDiagnostics'] = function() end,
    },
})

-- go

config_lsp('gopls', {
    filetypes = { 'go' },
    root_markers = { 'go.work', 'go.mod' },
})

-- python

config_lsp('jedi-language-server', {
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

local lua_server = vim.fn.exepath('lua-language-server')
if lua_server == '' then
    lua_server = vim.fn.stdpath('config') .. '/lls/bin/lua-language-server'
end

config_lsp('lua-language-server', {
    cmd = { lua_server },
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
