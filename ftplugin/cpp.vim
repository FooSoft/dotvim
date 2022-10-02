" vim-fswitch
noremap gfs :HFlip<Cr>

if has('nvim')
lua << EOF
    vim.diagnostic.disable()
EOF
endif
