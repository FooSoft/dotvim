let mapleader = "\<Space>"

" core
nnoremap <Bs> :bd!<Cr>
nnoremap <kMinus> <C-W>-
nnoremap <kPlus> <C-W>+
nnoremap <leader><leader> :b#<Cr>
nnoremap <leader>w :w<Cr>
nnoremap <silent> <Esc><Esc> :nohlsearch<Cr>
nnoremap <silent> <leader>n :set relativenumber!<Cr>
nnoremap Q <Nop>
nnoremap j gj
nnoremap k gk
noremap <C-c> <Esc>

" vim-argwrap
nnoremap <silent> <leader>a :ArgWrap<Cr>

" vim-bufonly
nnoremap <silent> <S-Bs> :BufOnly<Cr>

" vim-easy-align
nmap ga <Plug>(EasyAlign)
vmap <Cr> <Plug>(EasyAlign)

" vim-go
auto FileType go nmap <leader>b <Plug>(go-build)
auto FileType go nmap <leader>c <Plug>(go-coverage)
auto FileType go nmap <leader>r <Plug>(go-run)
auto FileType go nmap <leader>t <Plug>(go-test)

" vim-fswitch
noremap <silent> <leader>fs :FSHere<Cr>

" open-browser.vim
nmap <leader>o <Plug>(openbrowser-smart-search)
vmap <leader>o <Plug>(openbrowser-smart-search)
