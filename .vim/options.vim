set nocompatible

filetype indent plugin on
colorscheme molokai
syntax enable

set autoindent
set autoread
set autowrite
set background=dark
set backspace=indent,eol,start
set complete-=i
set completeopt=longest,menuone
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
set mousemodel=popup
set nobackup
set nofoldenable
set noswapfile
set nowrap
set nowritebackup
set nrformats-=octal
set number
set ruler
set scrolloff=5
set shiftround
set shiftwidth=4
set shortmess+=I
set smarttab
set tabstop=4
set ttimeout
set ttimeoutlen=100
set ttyfast
set wildignore+=*/tmp/*
set wildmenu

if has('gui_running')
    set columns=128
    set lines=32

    set guioptions-=L
    set guioptions-=R
    set guioptions-=T
    set guioptions-=l
    set guioptions-=m
    set guioptions-=r

    if has('win32')
        set guifont=Lucida_Console:h12
    else
        set guifont=Monospace\ 12
    endif
endif

if has('unix')
    set t_Co=256
endif

if &shell =~ 'bin/fish'
    set shell=/bin/sh
endif
