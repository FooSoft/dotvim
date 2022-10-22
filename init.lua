vim.cmd.colorscheme('solarized8')

vim.g.mapleader = ' '

vim.opt.autowrite = true
vim.opt.backup = false
vim.opt.completeopt = 'menuone,noselect'
vim.opt.expandtab = true
vim.opt.fileformats = 'unix,dos,mac'
vim.opt.foldenable = false
vim.opt.guicursor = 'n:blinkon0'
vim.opt.ignorecase = true
vim.opt.langremap = false
vim.opt.linebreak = true
vim.opt.modeline = false
vim.opt.modelines = 0
vim.opt.number = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.updatetime = 300
vim.opt.wrap = false
vim.opt.writebackup = false

-- gui
vim.api.nvim_create_autocmd(
    'UIEnter', {
        callback = function()
            if vim.v.event.chan == 1 then
                require('ginit')
            end
        end,
        once = true,
    }
)

-- general
vim.keymap.set('i', '<c-c>', '<esc>')
vim.keymap.set('n', '<bs>', '<cmd>bd<cr>')
vim.keymap.set('n', '<c-c><c-c>', '<cmd>nohlsearch<cr>')
vim.keymap.set('n', '<leader><leader>', '<cmd>b#<cr>')
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>')
vim.keymap.set('n', '<leader>x', '<cmd>x<cr>')
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P')
vim.keymap.set({ 'n', 'v' }, '<leader>Y', '"+y$')
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"+d')
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"+dd')
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p')
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'v' }, '<leader>yy', '"+yy')

-- splits
vim.keymap.set('n', '<a-=>', '<c-w><c-=>')
vim.keymap.set('n', '<a-h>', '<c-w><')
vim.keymap.set('n', '<a-j>', '<c-w>+')
vim.keymap.set('n', '<a-k>', '<c-w>-')
vim.keymap.set('n', '<a-l>', '<c-w>>')
vim.keymap.set('n', '<c-h>', '<c-w>h')
vim.keymap.set('n', '<c-j>', '<c-w>j')
vim.keymap.set('n', '<c-k>', '<c-w>k')
vim.keymap.set('n', '<c-l>', '<c-w>l')

-- cmp-nvim-lsp, nvim-lspconfig
local nvim_lspconfig = require('lspconfig')
if nvim_lspconfig then
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    if cmp_nvim_lsp then
        capabilities = cmp_nvim_lsp.update_capabilities(capabilities, { snippetSupport = false })
    end

    nvim_lspconfig.clangd.setup({ capabilities = capabilities })
    nvim_lspconfig.gopls.setup({ capabilities = capabilities })
    nvim_lspconfig.jedi_language_server.setup({ capabilities = capabilities })
    nvim_lspconfig.rust_analyzer.setup({ capabilities = capabilities })
    nvim_lspconfig.tsserver.setup({ capabilities = capabilities })
    nvim_lspconfig.vimls.setup({ capabilities = capabilities })
    nvim_lspconfig.sumneko_lua.setup({
        settings = {
            Lua = {
                diagnostics = { globals = { 'vim' } },
                runtime = { version = 'LuaJIT' },
                telemetry = { enable = false },
                workspace = { library = vim.api.nvim_get_runtime_file('', true) },
            },
        },
    })

    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format({ async = true }) end)
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
end

-- nvim-cmp
local nvim_cmp = require('cmp')
if nvim_cmp then
    nvim_cmp.setup({
        mapping = {
            ['<c-d>'] = nvim_cmp.mapping.scroll_docs(-4),
            ['<c-f>'] = nvim_cmp.mapping.scroll_docs(4),
            ['<c-n>'] = nvim_cmp.mapping.select_next_item(),
            ['<c-p>'] = nvim_cmp.mapping.select_prev_item(),
            ['<tab>'] = nvim_cmp.mapping.confirm({ select = true }),
        },
        sources = {
            { name = 'nvim_lsp' },
            { name = 'vsnip' },
        },
        snippet = {
            expand = function(args) vim.fn['vsnip#anonymous'](args.body) end,
        },
    })
end

-- telescope.nvim
local telescope = require('telescope')
if telescope then
    local telescope_builtin = require('telescope.builtin')
    if telescope_builtin then
        vim.keymap.set('n', '<space>fb', telescope_builtin.buffers, {})
        vim.keymap.set('n', '<space>fg', telescope_builtin.git_files, {})
        vim.keymap.set('n', '<space>fh', telescope_builtin.oldfiles, {})
        vim.keymap.set('n', '<space>fr', telescope_builtin.reloader, {})
        vim.keymap.set('n', '<space>fs', telescope_builtin.spell_suggest, {})
    end

    local telescope_actions = require('telescope.actions')
    telescope.setup {
        defaults = {
            mappings = {
                i = {
                    ['<c-j>'] = telescope_actions.move_selection_next,
                    ['<c-k>'] = telescope_actions.move_selection_previous,
                    ['<esc>'] = telescope_actions.close,
                },
            },
        }
    }
end

-- vim-airline
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline_symbols_ascii'] = 1

-- vim-argwrap
vim.keymap.set('n', '<leader>a', '<cmd>ArgWrap<cr>')

-- vim-better-whitespace
vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = '#6c71c4' })

-- vim-dirvish
vim.g.dirvish_mode = ':sort ,^.*[\\/],'

-- vim-easy-align
vim.g.easy_align_ignore_groups = {}
vim.keymap.set('n', 'ga', '<plug>(EasyAlign)')
vim.keymap.set('v', '<cr>', '<plug>(EasyAlign)')

-- vim-go
vim.g.go_diagnostics_enabled = 0
vim.g.go_imports_autosave = 0
vim.g.go_metalinter_enabled = {}
vim.g.go_null_module_warning = 0
vim.g.go_version_warning = 0

-- vim-interestingwords
vim.g.interestingWordsGUIColors = { '#8ccbea', '#a4e57e', '#ffdb72', '#ff7272', '#ffb3ff', '#9999ff' }
vim.g.interestingWordsTermColors = { '154', '121', '211', '137', '214', '222' }

-- vim-polyglot
vim.g.rustfmt_autosave = 1

-- hflip.nvim
vim.keymap.set('n', 'gfs', '<cmd>HFlip<cr>')
