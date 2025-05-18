if not vim.lsp.enable then
    return
end

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local opts = {
            buffer = args.buf,
            noremap = true,
        }

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

vim.keymap.set('i', '<tab>', function()
        if vim.fn.pumvisible() == 1 then
            return '<c-y>'
        else
            return '<tab>'
        end
    end,
    {expr = true, noremap = true}
)

vim.keymap.set('i', '<cr>', function()
        if vim.fn.pumvisible() == 1 then
            return '<c-e><cr>'
        else
            return '<cr>'
        end
    end,
    {expr = true, noremap = true}
)

vim.lsp.config('*', {
    root_markers = {'.git'},
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

config_lsp({
    cmd = {'clangd', '--background-index', '--header-insertion=never'},
    filetypes = {'cpp', 'c'},
    root_markers = {'compile_commands.json'},
})

-- go

config_lsp({
    cmd = {'gopls'},
    filetypes = {'go'},
    root_markers = {'go.mod'},
})

-- python

config_lsp({
    cmd = {'jedi-language-server'},
    filetypes = {'python'},
})

-- lua

vim.env.PATH = vim.env.PATH .. ':' .. vim.fn.stdpath('config') .. '/lls/bin'

local runtime_path = vim.split(package.path, ';', {})
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

config_lsp({
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
