" vim-pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" ale
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 'never'
let g:ale_linters = {'go': ['gofmt', 'go vet', 'go build']}

" fzf
let $FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -f -g "" 2> /dev/null'

" vim-airline
let g:airline#extensions#tabline#enabled = 1

" vim-argwrap
autocmd FileType go let b:argwrap_tail_comma = 1

" vim-go
let g:go_fmt_command = 'goimports'

" vim-interestinwords
let g:interestingWordsGUIColors = ['#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF']
let g:interestingWordsTermColors = ['154', '121', '211', '137', '214', '222']

" vim-licenses
let g:licenses_authors_name = 'Alex Yatskov <alex@foosoft.net>'
let g:licenses_copyright_holders_name = g:licenses_authors_name

" vim-rooter
let g:rooter_silent_chdir = 1

" YouCompleteMe
let g:ycm_check_if_ycm_core_present = 0
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = $HOME.'/.vim/ycm.py'
