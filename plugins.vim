" coc.nvim
if executable('node')
    packadd coc.nvim

    highlight CocErrorSign ctermfg=Red guifg=#dc322f
    highlight CocWarningSign ctermfg=Yellow guifg=#b58900
    highlight CocInfoHighlight ctermfg=Blue guifg=#268bd2

    let g:coc_disable_startup_warning = 1

    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    if has('nvim-0.4.0') || has('patch-8.2.0750')
        nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
        nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
        inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
        inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
        vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
        vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    endif

    inoremap <expr><tab> pumvisible() ? '<C-y>' : '<tab>'
    inoremap <expr><cr> pumvisible() ? '<C-e><cr>' : '<cr>'
endif

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
let g:go_fmt_command = 'goimports'
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
