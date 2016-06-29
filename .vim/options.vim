set nocompatible

if &shell =~ 'bin/fish'
    set shell=/bin/sh
endif

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

filetype indent plugin on
colorscheme molokai
syntax enable

set autochdir
set autoread
set autowrite
set background=dark
set backspace=indent,eol,start
set completeopt-=preview
set encoding=utf-8
set expandtab
set fileformats=unix,dos,mac
set hidden
set history=1000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set linebreak
set mouse=
set mousemodel=popup
set nobackup
set nofoldenable
set noswapfile
set nowrap
set nrformats-=octal
set number
set scrolloff=5
set shiftround
set shiftwidth=4
set shortmess+=I
set smartcase
set smartcase
set smarttab
set t_Co=256
set tabstop=4
set ttyfast
set wildignore+=*/tmp/*
set wildmenu

if has('gui_running')
    set columns=150
    set lines=50

    set guioptions-=L
    set guioptions-=R
    set guioptions-=T
    set guioptions-=l
    set guioptions-=m
    set guioptions-=r
endif
