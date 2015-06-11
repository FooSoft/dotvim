let mapleader = ','

" core
nnoremap <silent> <Bs> :bd<Cr>
nnoremap <silent> <Esc><Esc> :nohlsearch<Cr>
nnoremap <silent> <leader>n :set relativenumber!<Cr>
nnoremap <silent> Q <Nop>
nnoremap <silent> j gj
nnoremap <silent> k gk

" vim-argwrap
nnoremap <silent> <leader>a :ArgWrap<Cr>

" vim-easy-align
vmap <Cr> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" vim-fswitch
noremap <silent> <leader>fs :FSHere<Cr>

" open-browser.vim
nmap <leader>o <Plug>(openbrowser-smart-search)
vmap <leader>o <Plug>(openbrowser-smart-search)
