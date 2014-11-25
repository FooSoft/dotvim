set runtimepath+=~/.vim
runtime bundle/vim-pathogen/autoload/pathogen.vim

let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='pdf, aux'
let g:licenses_authors_name = 'Alex Yatskov <alex@foosoft.net>'
let g:table_mode_corner='|'
let mapleader=","

call pathogen#infect()
call pathogen#helptags()

colorscheme wombat256
filetype indent plugin on
syntax on

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

nnoremap <silent> <C-h> :bnext<CR>
nnoremap <silent> <C-l> :bprev<CR>
nnoremap <silent> <Leader>h :noh<CR>
nnoremap <silent> <Leader>w gqip
nnoremap <silent> <leader>g :call argumentrewrap#RewrapArguments()<CR>
nnoremap <silent> <leader>s :source %<CR>
nnoremap Q <Nop>

vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)

if has("gui_running")
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
