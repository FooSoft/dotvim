" fzf
let $FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -f -g "" 2> /dev/null'
if has('windows')
    let g:fzf_preview_window = ''
endif
let g:fzf_colors = {
    \ 'bg': ['bg', 'Normal'],
    \ 'bg+': ['bg', 'CursorLine', 'CursorColumn'],
    \ 'border': ['fg', 'Ignore'],
    \ 'fg': ['fg', 'Normal'],
    \ 'fg+': ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'header': ['fg', 'Comment'],
    \ 'hl': ['fg', 'Comment'],
    \ 'hl+': ['fg', 'Statement'],
    \ 'info': ['fg', 'PreProc'],
    \ 'marker': ['fg', 'Keyword'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'prompt': ['fg', 'Conditional'],
    \ 'spinner': ['fg', 'Label'],
    \ }

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_symbols_ascii = 1

" vim-dirvish
let g:dirvish_mode = ':sort ,^.*[\/],'

" vim-easy-align
let g:easy_align_ignore_groups = []

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

" vim-markdown
let g:vim_markdown_folding_disabled = 1
