-- neodev.nvim
local neodev_nvim = require('neodev')
neodev_nvim.setup({})

-- cmp-nvim-lsp
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local capabilities = cmp_nvim_lsp.default_capabilities({snippetSupport = false})

-- nvim-lspconfig
local nvim_lspconfig = require('lspconfig')
if vim.fn.executable('clangd') then
    nvim_lspconfig.clangd.setup({capabilities = capabilities})
end
if vim.fn.executable('gopls') then
    nvim_lspconfig.gopls.setup({capabilities = capabilities})
end
if vim.fn.executable('jedi-language-server') then
    nvim_lspconfig.jedi_language_server.setup({capabilities = capabilities})
end
if vim.fn.executable('typescript-language-server') then
    nvim_lspconfig.tsserver.setup({capabilities = capabilities})
end
if vim.fn.executable('lua-language-server') then
    nvim_lspconfig.sumneko_lua.setup({
        settings = {
            Lua = {
                diagnostics = {globals = {'vim'}},
                runtime = {version = 'LuaJIT'},
                telemetry = {enable = false},
                workspace = {library = vim.api.nvim_get_runtime_file('', true)},
            },
        },
    })
end

vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help)
vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition)
vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action)
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format({async = true}) end)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename)
vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder)
vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end)
vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder)
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)

vim.opt.omnifunc = 'v:lua.vim.lsp.omnifunc'

-- nvim-cmp
local nvim_cmp = require('cmp')
nvim_cmp.setup({
    mapping = {
        ['<c-d>'] = nvim_cmp.mapping.scroll_docs(-4),
        ['<c-f>'] = nvim_cmp.mapping.scroll_docs(4),
        ['<c-n>'] = nvim_cmp.mapping.select_next_item(),
        ['<c-p>'] = nvim_cmp.mapping.select_prev_item(),
        ['<tab>'] = nvim_cmp.mapping.confirm({ select = true }),
    },
    sources = {
        {name = 'nvim_lsp'},
        {name = 'vsnip'},
        {name = "nvim_lsp_signature_help"},
    },
    snippet = {
        expand = function(args) vim.fn['vsnip#anonymous'](args.body) end,
    },
})
