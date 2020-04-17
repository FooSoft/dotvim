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
    if len($PYTHON3_HOST_PROG) > 0
        let g:python3_host_prog=$PYTHON3_HOST_PROG
    endif
endif

" LanguageClient-neovim
let g:LanguageClient_serverCommands = {
  \ 'go': ['gopls'],
  \ 'python': ['pyls'],
  \ }

" fzf
let $FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -f -g "" 2> /dev/null'
let g:fzf_colors =  {
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

" vim-airline
let g:airline#extensions#tabline#enabled = 1

" vim-argwrap
autocmd FileType go let b:argwrap_tail_comma = 1

" vim-go
let g:go_fmt_command = 'goimports'
let g:go_null_module_warning = 0
let g:go_version_warning = 0

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
