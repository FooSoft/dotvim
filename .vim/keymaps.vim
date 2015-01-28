let mapleader = ','

" core
nnoremap <silent> <C-h>      :bnext<CR>
nnoremap <silent> <C-l>      :bprevious<CR>
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
nnoremap <silent> Q          <Nop>

" vim-argwrap
nnoremap <silent> <leader>a :call argwrap#toggle()<CR>

" vim-easy-align
vmap <Enter> <Plug>(EasyAlign)
