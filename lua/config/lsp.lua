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

vim.api.nvim_create_autocmd('CursorHoldI', {
    group = vim.api.nvim_create_augroup('signature_help', { clear = true }),
    callback = function(args)
        local clients = vim.lsp.get_clients({
            bufnr = args.buf,
            method = 'textDocument/signatureHelp',
        })
        if #clients > 0 then
            vim.lsp.buf.signature_help({ focusable = false })
        end
    end,
    desc = 'Show signature help when typing pauses',
})

local clangd_diagnostics = {}

if not util.is_windows() then
    vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('clangd_includes', { clear = true }),
        callback = function(args)
            for _, client in ipairs(vim.lsp.get_clients({ bufnr = args.buf, name = 'clangd' })) do
                local uri = vim.uri_from_bufnr(args.buf)
                local function current_diagnostics()
                    local result = (clangd_diagnostics[client.id] or {})[uri]
                    if result and result.version == vim.lsp.util.buf_versions[args.buf] then
                        return result.diagnostics
                    end
                end
                if not current_diagnostics() then
                    -- Flush pending changes and wait for clangd to analyze this buffer version.
                    local response = client:request_sync('textDocument/documentSymbol', {
                        textDocument = { uri = uri },
                    }, 1000, args.buf)
                    if not response or response.err
                        or not vim.wait(1000, function() return current_diagnostics() ~= nil end, 10) then
                        return
                    end
                end

                local diagnostics = {}
                for _, diagnostic in ipairs(current_diagnostics() or {}) do
                    if diagnostic.code == 'unused-includes' or diagnostic.code == 'missing-includes' then
                        diagnostics[#diagnostics + 1] = diagnostic
                    end
                end
                if #diagnostics == 0 then
                    return
                end

                local response = client:request_sync('textDocument/codeAction', {
                    textDocument = { uri = uri },
                    range = diagnostics[1].range,
                    context = { diagnostics = diagnostics, only = { 'quickfix' } },
                }, 1000, args.buf)
                if not response or response.err then
                    return
                end

                local fix
                for _, action in ipairs(response.result or {}) do
                    if not action.disabled and action.edit then
                        if action.title == 'fix all includes' then
                            fix = action
                            break
                        elseif action.title == 'remove all unused includes'
                            or action.title == 'add all missing includes'
                            or (#diagnostics == 1 and (action.title == 'remove #include directive'
                                or action.title:match('^#include '))) then
                            fix = action
                        end
                    end
                end
                if fix then
                    -- clangd can put a deletion before insertions at the same position.
                    -- Neovim applies equal-position edits in reverse order, so delete first.
                    local edits = fix.edit.changes and fix.edit.changes[uri]
                    if edits then
                        local ordered = {}
                        for _, edit in ipairs(edits) do
                            if edit.newText ~= '' then
                                ordered[#ordered + 1] = edit
                            end
                        end
                        for _, edit in ipairs(edits) do
                            if edit.newText == '' then
                                ordered[#ordered + 1] = edit
                            end
                        end
                        fix.edit.changes[uri] = ordered
                    end
                    -- Apply synchronously so include fixes reach disk before formatting and writing.
                    vim.lsp.util.apply_workspace_edit(fix.edit, client.offset_encoding)
                end
            end
        end,
        desc = 'Add missing and remove unused includes with clangd before saving',
    })
end

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
else
    table.insert(clangd_cmd, '--header-insertion=iwyu')
    table.insert(clangd_cmd, '--clang-tidy')
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
        ['textDocument/publishDiagnostics'] = function(err, result, ctx, config)
            if util.is_windows() then
                return
            end
            if not err and result then
                clangd_diagnostics[ctx.client_id] = clangd_diagnostics[ctx.client_id] or {}
                clangd_diagnostics[ctx.client_id][result.uri] = result.version and result or nil
            end
            vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
        end,
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
