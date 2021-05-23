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

" coc.vim
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

inoremap <expr><tab> pumvisible() ? '<C-y>' : '<tab>'
inoremap <expr><cr> pumvisible() ? '<C-e><cr>' : '<cr>'

" fzf
nnoremap <silent><leader>fg :GFiles<cr>
nnoremap <silent><leader>ff :Files ~<cr>
nnoremap <silent><leader>fh :History<cr>
nnoremap <silent><leader>fc :BCommits<cr>
nnoremap <silent><leader>fb :Buffers<cr>
nnoremap <silent><leader>fl :Lines<cr>

" vim-argwrap
nnoremap <silent><leader>a :ArgWrap<cr>

" vim-easy-align
nmap ga <plug>(EasyAlign)
vmap <cr> <plug>(EasyAlign)
