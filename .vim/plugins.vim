" vim-pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect('bundle/{}')

" ale
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 'never'
let g:ale_linters = {'go': ['gofmt', 'go vet', 'go build']}

" deoplete.nvim
if has('python3')
    let g:deoplete#enable_at_startup = 1
    inoremap <expr><TAB> pumvisible() ? "\<C-y>" : "\<TAB>"
    if len($PYTHON3_HOST_PROG) > 0
        let g:python3_host_prog=$PYTHON3_HOST_PROG
    endif
endif

" fzf
let $FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -f -g "" 2> /dev/null'
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" vim-airline
let g:airline#extensions#tabline#enabled = 1

" vim-argwrap
autocmd FileType go let b:argwrap_tail_comma = 1

" vim-go
let g:go_fmt_command = 'goimports'
let g:go_null_module_warning = 0

" vim-header
let g:header_auto_add_header = 0
let g:header_field_author = 'Alex Yatskov'
let g:header_field_author_email = 'alex@foosoft.net'
let g:header_field_filename = 0

" vim-interestinwords
let g:interestingWordsGUIColors = ['#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF']
let g:interestingWordsTermColors = ['154', '121', '211', '137', '214', '222']

" vim-rooter
let g:rooter_silent_chdir = 1

" vim-markdown
let g:vim_markdown_folding_disabled = 1
