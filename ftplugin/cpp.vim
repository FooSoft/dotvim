" vim-fswitch
noremap gfs :FSHere<Cr>

if has('nvim')
lua << EOF
    vim.diagnostic.disable()
EOF
endif
