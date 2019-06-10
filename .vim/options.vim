set nocompatible

filetype indent plugin on
colorscheme base16-default-dark
syntax enable

set autoindent
set autoread
set autowrite
set background=dark
set backspace=indent,eol,start
set complete-=i
set completeopt=longest,menuone,noinsert
set encoding=utf-8
set expandtab
set fileformats=unix,dos,mac
set guicursor=n:blinkon0
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
set sidescroll=1
set smartcase
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

    if has('unix')
        set guifont=Source\ Code\ Pro\ Regular\ 12
    else
        set guifont=Terminus:h12
    endif
endif

if has('unix')
    set termguicolors
    set t_Co=256
endif

if &shell =~ 'bin/fish'
    set shell=/bin/sh
endif
