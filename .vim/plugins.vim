" vim-pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" ctrlp.vim
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'ra'

" vim-airline
let g:airline#extensions#tabline#enabled = 1

" vim-argwrap
autocmd FileType go let b:argwrap_tail_comma = 1

" vim-gitgutter
let g:gitgutter_max_signs = 10000

" vim-go
let g:go_fmt_command = 'goimports'

" vim-licenses
let g:licenses_authors_name = 'Alex Yatskov <alex@foosoft.net>'
let g:licenses_copyright_holders_name = g:licenses_authors_name

" vim-rooter
let g:rooter_silent_chdir = 1

" YouCompleteMe
let g:ycm_check_if_ycm_core_present = 0
let g:ycm_confirm_extra_conf = 0
