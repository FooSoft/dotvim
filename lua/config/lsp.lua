local util = require('config.util')

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
        util.keymap('i', '<c-space>', '<c-x><c-o>', { buffer = args.buf })

        util.keymap('i', '<tab>', function()
            return vim.fn.pumvisible() == 1 and '<c-y>' or '<tab>'
        end, { buffer = args.buf, expr = true })

        util.keymap('i', '<cr>', function()
            return vim.fn.pumvisible() == 1 and '<c-e><cr>' or '<cr>'
        end, { buffer = args.buf, expr = true })

        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client:supports_method('textDocument/completion') then
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

local function fix_clangd_includes(bufnr)
    local client = vim.lsp.get_clients({ bufnr = bufnr, name = 'clangd' })[1]
    if not client then
        return
    end

    local started = vim.uv.hrtime()
    local function time_left()
        return math.max(0, 1000 - math.floor((vim.uv.hrtime() - started) / 1e6))
    end
    local function current_diagnostics()
        local result = vim.b[bufnr].clangd_diagnostics
        if result and result.client_id == client.id and result.version == vim.lsp.util.buf_versions[bufnr] then
            return result.diagnostics
        end
    end

    local uri = vim.uri_from_bufnr(bufnr)
    if not current_diagnostics() then
        -- This request flushes pending edits and waits for clangd to parse them.
        local response = client:request_sync('textDocument/documentSymbol', {
            textDocument = { uri = uri },
        }, time_left(), bufnr)
        if not response or response.err
            or not vim.wait(time_left(), function() return current_diagnostics() ~= nil end, 10) then
            return
        end
    end

    local diagnostics = vim.tbl_filter(function(diagnostic)
        return diagnostic.code == 'unused-includes' or diagnostic.code == 'missing-includes'
    end, current_diagnostics() or {})
    if #diagnostics == 0 or time_left() == 0 then
        return
    end

    local response = client:request_sync('textDocument/codeAction', {
        textDocument = { uri = uri },
        range = diagnostics[1].range,
        context = { diagnostics = diagnostics, only = { 'quickfix' } },
    }, time_left(), bufnr)
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
    if not fix then
        return
    end

    -- Neovim applies equal-position edits in reverse order: delete before inserting.
    local function order_edits(edits)
        local insertions, deletions = {}, {}
        for _, edit in ipairs(edits) do
            local target = edit.newText == '' and deletions or insertions
            target[#target + 1] = edit
        end
        return vim.list_extend(insertions, deletions)
    end
    if fix.edit.changes and fix.edit.changes[uri] then
        fix.edit.changes[uri] = order_edits(fix.edit.changes[uri])
    end
    for _, change in ipairs(fix.edit.documentChanges or {}) do
        if change.textDocument and change.textDocument.uri == uri then
            change.edits = order_edits(change.edits)
        end
    end
    vim.lsp.util.apply_workspace_edit(fix.edit, client.offset_encoding)
end

local function organize_go_imports(bufnr)
    local client = vim.lsp.get_clients({ bufnr = bufnr, name = 'gopls', method = 'textDocument/codeAction' })[1]
    if not client then
        return
    end

    local range_params = vim.lsp.util.make_range_params(0, client.offset_encoding)
    local params = {
        textDocument = range_params.textDocument,
        range = range_params.range,
        context = { diagnostics = {}, only = { 'source.organizeImports' } },
    }
    -- Wait for import edits so they are formatted and included in this write.
    local response, err = client:request_sync('textDocument/codeAction', params, 3000, bufnr)
    if not response or response.err then
        vim.notify('Could not organize Go imports: '
            .. (err or (response and response.err.message) or 'request failed'), vim.log.levels.WARN)
        return
    end
    for _, action in ipairs(response.result or {}) do
        if action.edit then
            vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
        end
    end
end

if util.is_unix() then
    vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('lsp_format', { clear = true }),
        callback = function(args)
            local filetype = vim.bo[args.buf].filetype
            if filetype == 'c' or filetype == 'cpp' then
                fix_clangd_includes(args.buf)
            elseif filetype == 'go' then
                organize_go_imports(args.buf)
            end
            local clients = vim.lsp.get_clients({ bufnr = args.buf, method = 'textDocument/formatting' })
            if clients[1] then
                vim.lsp.buf.format({ bufnr = args.buf, id = clients[1].id, async = false })
            end
        end,
        desc = 'Fix C/C++ includes and Go imports, then format with an attached language server',
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
                vim.b[vim.uri_to_bufnr(result.uri)].clangd_diagnostics = result.version and {
                    client_id = ctx.client_id, version = result.version, diagnostics = result.diagnostics,
                } or nil
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
