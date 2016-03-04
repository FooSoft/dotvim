let mapleader = "\<Space>"

" core
nnoremap <Bs> :bd!<Cr>
nnoremap <kMinus> <C-W>-
nnoremap <kPlus> <C-W>+
nnoremap <Leader><Leader> :b#<Cr>
nnoremap <Leader>w :w<Cr>
nnoremap <Leader>x :x<Cr>
nnoremap <silent> <Esc><Esc> :nohlsearch<Cr>
nnoremap <silent> <Leader>n :set relativenumber!<Cr>
nnoremap Q <Nop>
nnoremap j gj
nnoremap k gk
noremap <C-c> <Esc>
vnoremap <Leader>y "+y
vnoremap <Leader>d "+d
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>p "+p
vnoremap <Leader>P "+P
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" vim-argwrap
nnoremap <silent> <Leader>a :ArgWrap<Cr>

" vim-bufonly
nnoremap <silent> <S-Bs> :BufOnly<Cr>

" vim-easy-align
nmap ga <Plug>(EasyAlign)
vmap <Cr> <Plug>(EasyAlign)

" vim-go
auto FileType go nmap <Leader>b <Plug>(go-build)
auto FileType go nmap <Leader>c <Plug>(go-coverage)
auto FileType go nmap <Leader>r <Plug>(go-run)
auto FileType go nmap <Leader>t <Plug>(go-test)

" vim-fswitch
noremap <silent> <Leader>fs :FSHere<Cr>

" open-browser.vim
nmap <Leader>o <Plug>(openbrowser-smart-search)
vmap <Leader>o <Plug>(openbrowser-smart-search)
