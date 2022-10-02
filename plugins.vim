" cmp-nvim-lsp, nvim-cmp, nvim-lspconfig
if has('nvim')
    packadd cmp-nvim-lsp
    packadd cmp-vsnip
    packadd nvim-cmp
    packadd nvim-lspconfig
    packadd vim-vsnip
    packadd hflip.nvim

lua << EOF
    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        -- Enable completion triggered by <c-x><c-o>
        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        local opts = { noremap=true, silent=true }

        -- See `:help vim.lsp.*` for documentation on any of the below functions
        buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
        buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
        buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
        buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    end

    -- Add additional capabilities supported by nvim-cmp
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities, {snippetSupport = false})

    -- Use a loop to conveniently call 'setup' on multiple servers and
    -- map buffer local keybindings when the language server attaches
    local nvim_lsp = require('lspconfig')
    for _, lsp in ipairs({'clangd', 'gopls', 'jedi_language_server', 'rust_analyzer', 'tsserver', 'vimls'}) do
        nvim_lsp[lsp].setup({
            on_attach = on_attach,
            capabilities = capabilities
        })
    end

    nvim_lsp.sumneko_lua.setup {
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {'vim'},
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file('', true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
    }

    -- nvim-cmp setup
    local cmp = require('cmp')
    cmp.setup {
        mapping = {
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<Tab>'] = cmp.mapping.confirm({select = true}),
        },
        sources = {
            {name = 'nvim_lsp'},
            {name = 'vsnip'},
        },
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
            end,
        },
    }

    -- Set completeopt to have a better completion experience
    vim.o.completeopt = 'menuone,noselect'

    -- Helper for dumping Lua tables
    function _G.put(...)
        local objects = {}
        for i = 1, select('#', ...) do
            local v = select(i, ...)
            table.insert(objects, vim.inspect(v))
        end

        print(table.concat(objects, '\n'))
        return ...
    end
EOF
endif

" hflip.nvim
command! HFlipReload lua require'plenary.reload'.reload_module('hflip', false)

" fzf
if executable('fzf')
    packadd fzf.vim
    packadd fzf

    let $FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -f -g "" 2> /dev/null'
    let g:fzf_colors = {
        \ 'bg':      ['bg', 'Normal'],
        \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
        \ 'border':  ['fg', 'Ignore'],
        \ 'fg':      ['fg', 'Normal'],
        \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
        \ 'header':  ['fg', 'Comment'],
        \ 'hl':      ['fg', 'Comment'],
        \ 'hl+':     ['fg', 'Statement'],
        \ 'info':    ['fg', 'PreProc'],
        \ 'marker':  ['fg', 'Keyword'],
        \ 'pointer': ['fg', 'Exception'],
        \ 'prompt':  ['fg', 'Conditional'],
        \ 'spinner': ['fg', 'Label'],
        \ }

    if has('windows')
        let g:fzf_preview_window = ''
    endif

    nnoremap <silent><leader>fg :GFiles<cr>
    nnoremap <silent><leader>ff :Files ~<cr>
    nnoremap <silent><leader>fh :History<cr>
    nnoremap <silent><leader>fc :BCommits<cr>
    nnoremap <silent><leader>fb :Buffers<cr>
    nnoremap <silent><leader>fl :Lines<cr>
endif

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_symbols_ascii = 1

" vim-argwrap
nnoremap <silent><leader>a :ArgWrap<cr>

" vim-better-whitespace
highlight ExtraWhitespace ctermbg=DarkMagenta guibg=#6c71c4

" vim-dirvish
let g:dirvish_mode = ':sort ,^.*[\/],'

" vim-easy-align
let g:easy_align_ignore_groups = []
nmap ga <plug>(EasyAlign)
vmap <cr> <plug>(EasyAlign)

" vim-go
let g:go_diagnostics_enabled = 0
let g:go_imports_autosave = 0
let g:go_metalinter_enabled = []
let g:go_null_module_warning = 0
let g:go_version_warning = 0

" vim-header
let g:header_auto_add_header = 0
let g:header_field_author = 'Alex Yatskov'
let g:header_field_author_email = 'alex@foosoft.net'
let g:header_field_filename = 0

" vim-interestingwords
let g:interestingWordsGUIColors = ['#8ccbea', '#a4e57e', '#ffdb72', '#ff7272', '#ffb3ff', '#9999ff']
let g:interestingWordsTermColors = ['154', '121', '211', '137', '214', '222']

" vim-polyglot
let g:rustfmt_autosave = 1
