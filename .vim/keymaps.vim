let mapleader = "\<Space>"

" core
nnoremap <silent><Leader><Leader> :b#<Cr>
nnoremap <silent><Esc><Esc> :nohlsearch<Cr>
nnoremap Q <Nop>
nnoremap Y y$
nnoremap <silent><Leader>m :make<Cr>
noremap <C-c> <Esc>
nnoremap <Leader>w :w<Cr>
nnoremap <Leader>x :x<Cr>

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
nnoremap <A-=> <C-W><C-=>

nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

nnoremap j gj
nnoremap k gk

" fzf
nnoremap <silent><Leader>fr :GFiles<Cr>
nnoremap <silent><Leader>fg :Files ~<Cr>
nnoremap <silent><Leader>fh :History<Cr>
nnoremap <silent><Leader>fc :BCommits<Cr>

" perforce checkout
nnoremap <silent><Leader>e :silent !p4 edit % <bar> set noro<Cr>

" vim-argwrap
nnoremap <silent><Leader>a :ArgWrap<Cr>

" vim-bbye
nnoremap <silent><Bs> :Bdelete<Cr>

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
auto FileType go nmap <Leader><F5> :GoDebugStart<Cr>
auto FileType go nmap <Leader><F9> :GoDebugBreakpoint<Cr>
auto FileType go nmap <S-F11> :GoDebugStepOut<Cr>
auto FileType go nmap <S-F5> :GoDebugStop<Cr>

" vim-fswitch
noremap <silent> <Leader>fs :FSHere<Cr>
