set nocompatible
set termguicolors
set t_Co=16

filetype indent plugin on
colorscheme solarized8
syntax enable

set autoindent
set autoread
set autowrite
set background=dark
set backspace=indent,eol,start
set belloff=all
set complete-=i
set completeopt=menuone,noinsert
set encoding=utf-8
set expandtab
set fileformats=unix,dos,mac
set formatoptions=tcqj
set guicursor=n:blinkon0
set hidden
set history=10000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set linebreak
set modelines=0
set mousemodel=popup
set nobackup
set nofoldenable
set nofsync
set nolangremap
set nomodeline
set noswapfile
set nowrap
set nowritebackup
set nrformats=bin,hex
set number
set ruler
set ruler
set scrolloff=5
set shiftround
set shiftwidth=4
set shortmess+=I
set showcmd
set sidescroll=1
set smartcase
set smarttab
set tabpagemax=50
set tabstop=4
set ttimeout
set ttimeoutlen=50
set ttyfast
set updatetime=300
set wildignore+=*/tmp/*
set wildmenu

if &shell =~ 'bin/fish'
    set shell=/bin/sh
endif
