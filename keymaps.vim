let mapleader = "\<Space>"

" core
nnoremap <silent><Leader><Leader> :b#<Cr>
nnoremap <silent><C-c><C-c> :nohlsearch<Cr>
nnoremap <silent><Leader>m :make<Cr>
nnoremap <silent><Leader>w :w<Cr>
nnoremap <silent><Leader>x :x<Cr>
inoremap <C-c> <Esc>
nnoremap Q <Nop>

nnoremap Y y$
nnoremap <Leader>Y "+y$
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

inoremap <expr><TAB> pumvisible() ? '<C-y>' : '<TAB>'
inoremap <expr><CR> pumvisible() ? '<C-e><CR>' : '<CR>'

" functions
nnoremap <Leader>ig :Guid<Cr>

" fzf
nnoremap <silent><Leader>fg :GFiles<Cr>
nnoremap <silent><Leader>ff :Files ~<Cr>
nnoremap <silent><Leader>fh :History<Cr>
nnoremap <silent><Leader>fc :BCommits<Cr>
nnoremap <silent><Leader>fb :Buffers<Cr>
nnoremap <silent><Leader>fl :Lines<Cr>

" vim-argwrap
nnoremap <silent><Leader>a :ArgWrap<Cr>

" vim-bbye
nnoremap <silent><Bs> :Bwipeout<Cr>

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
auto FileType cpp noremap <silent> <Leader>fs :FSHere<Cr>