let mapleader = "\<Space>"

" core
nnoremap <silent><Leader>w :w<Cr>
nnoremap <silent><Leader>x :x<Cr>
nnoremap <silent><Bs> :bd!<Cr>
nnoremap <silent><C-Bs> <C-W>q
nnoremap <silent><Leader><Leader> :b#<Cr>
nnoremap <silent><Esc><Esc> :nohlsearch<Cr>
nnoremap Q <Nop>
noremap <C-c> <Esc>

vnoremap <Leader>y "+y
vnoremap <Leader>d "+d
vnoremap <Leader>p "+p
vnoremap <Leader>P "+P
nnoremap <Leader>y "+y
nnoremap <Leader>d "+d
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
nnoremap <Leader>yy "+yy
nnoremap <Leader>d "+dd

nnoremap <A-k> <C-W>-
nnoremap <A-j> <C-W>+
nnoremap <A-h> <C-W><
nnoremap <A-l> <C-W>>

noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

nnoremap j gj
nnoremap k gk

" vim-argwrap
nnoremap <silent><Leader>a :ArgWrap<Cr>

" vim-bufonly
nnoremap <silent><S-Bs> :BufOnly<Cr>

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
