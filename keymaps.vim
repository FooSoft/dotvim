let mapleader = "\<space>"

" core
nnoremap <silent><leader><leader> :b#<cr>
nnoremap <silent><c-c><c-c> :nohlsearch<cr>
nnoremap <silent><leader>m :make<cr>
nnoremap <silent><leader>w :w<cr>
nnoremap <silent><leader>x :x<cr>
inoremap <C-c> <esc>
nnoremap Q <nop>

nnoremap Y y$
nnoremap <leader>Y "+y$
vnoremap <leader>y "+y
vnoremap <leader>d "+d
vnoremap <leader>p "+p
vnoremap <leader>P "+P
nnoremap <leader>y "+y
nnoremap <leader>d "+d
nnoremap <leader>p "+p
nnoremap <leader>P "+P
nnoremap <leader>yy "+yy
nnoremap <leader>d "+dd

nnoremap <silent><bs> :bd<cr>
nnoremap <silent><s-bs> :bd!<cr>

nnoremap <a-k> <c-w>-
nnoremap <a-j> <c-w>+
nnoremap <a-h> <c-w><
nnoremap <a-l> <c-w>>
nnoremap <a-=> <c-w><c-=>

nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

nnoremap j gj
nnoremap k gk

" util
nnoremap <leader>ig :Guid<cr>
