call plug#begin('~/.vim/plugged')

Plug 'git://git.code.sf.net/p/vim-latex/vim-latex'
Plug 'https://github.com/FooSoft/vim-argwrap.git'
Plug 'https://github.com/Lokaltog/vim-easymotion.git'
Plug 'https://github.com/antoyo/vim-licenses.git'
Plug 'https://github.com/bkad/CamelCaseMotion'
Plug 'https://github.com/bling/vim-airline.git'
Plug 'https://github.com/dhruvasagar/vim-table-mode.git'
Plug 'https://github.com/flazz/vim-colorschemes.git'
Plug 'https://github.com/junegunn/vim-easy-align.git'
Plug 'https://github.com/kien/ctrlp.vim.git'
Plug 'https://github.com/mattn/emmet-vim.git'
Plug 'https://github.com/michaeljsmith/vim-indent-object.git'
Plug 'https://github.com/nathanaelkane/vim-indent-guides.git'
Plug 'https://github.com/ntpeters/vim-better-whitespace.git'
Plug 'https://github.com/pangloss/vim-javascript.git'
Plug 'https://github.com/plasticboy/vim-markdown.git'
Plug 'https://github.com/scrooloose/syntastic.git'
Plug 'https://github.com/tpope/vim-abolish.git'
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/tpope/vim-eunuch.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/tpope/vim-pathogen.git'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-unimpaired.git'

call plug#end()

" syntastic
let g:syntastic_python_checkers  = ['pyflakes']

" vim-argwrap
let g:argwrap_padded_braces      = '{'

" vim-latex
let g:Tex_DefaultTargetFormat    = 'pdf'
let g:Tex_MultipleCompileFormats = 'pdf, aux'

" vim-licenses
let g:licenses_authors_name      = 'Alex Yatskov <alex@foosoft.net>'

" vim-table-mode
let g:table_mode_corner          = '|'
