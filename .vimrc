set runtimepath+=~/.vim

" vim-pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

" vim-latex
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='pdf, aux'

" vim-licenses
let g:licenses_authors_name='Alex Yatskov <alex@foosoft.net>'

" vim-table-mode
let g:table_mode_corner='|'
let g:syntastic_python_checkers=['pyflakes']
let g:mapleader=','

colorscheme wombat256
filetype indent plugin on
syntax enable

augroup general
    autocmd!
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    autocmd BufRead,BufNewFile *.md set filetype=markdown
augroup END

set autochdir
set autoread
set autowrite
set backspace=indent,eol,start
set encoding=utf-8
set expandtab
set fileformats=unix,dos,mac
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set linebreak
set mouse=nvi
set mousemodel=popup
set nobackup
set nocompatible
set nofoldenable
set noswapfile
set nowrap
set number
set path=$VIMPATH
set scrolloff=5
set shiftwidth=4
set shortmess+=I
set smartcase
set smarttab
set tabstop=4
set wildmenu
set wrapmargin=1

if has('gui_running')
    set columns=150
    set cursorline
    set guioptions-=L
    set guioptions-=R
    set guioptions-=T
    set guioptions-=l
    set guioptions-=m
    set guioptions-=r
    set lines=50
endif

if $SHELL=~'bin/fish'
    set shell=/bin/sh
endif

nnoremap <silent> <C-h> :bnext<CR>
nnoremap <silent> <C-l> :bprevious<CR>
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
inoremap <silent> '' <Esc>
nnoremap Q <Nop>

" vim-easy-align
vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)

" vim-arg-wrap
nnoremap <silent> <leader>a :call argwrap#toggle()<CR>
