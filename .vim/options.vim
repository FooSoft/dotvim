filetype indent plugin on
colorscheme wombat256
syntax enable

set nocompatible

set autochdir
set autoread
set autowrite
set backspace=indent,eol,start
set encoding=utf-8
set expandtab
set fileformats=unix,dos,mac
set formatoptions-=c
set formatoptions-=o
set formatoptions-=r
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set linebreak
set mouse=nvi
set mousemodel=popup
set nobackup
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

if $SHELL =~ 'bin/fish'
    set shell=/bin/sh
endif