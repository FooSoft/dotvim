filetype indent plugin on
colorscheme molokai
syntax enable

set autochdir
set autoread
set autowrite
set backspace=indent,eol,start
set encoding=utf-8
set expandtab
set fileformats=unix,dos,mac
set hlsearch
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
    set guifont=Terminus\ 12
    set guioptions-=L
    set guioptions-=R
    set guioptions-=T
    set guioptions-=l
    set guioptions-=m
    set guioptions-=r
    set lines=50
endif

if &shell =~ 'bin/fish'
    set shell=/bin/sh
endif
