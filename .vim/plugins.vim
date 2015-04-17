call plug#begin('~/.vim/plugged')

Plug 'FooSoft/vim-argwrap.git'
Plug 'Lokaltog/vim-easymotion.git'
Plug 'airblade/vim-gitgutter.git'
Plug 'antoyo/vim-licenses.git'
Plug 'bkad/CamelCaseMotion'
Plug 'bling/vim-airline.git'
Plug 'cespare/vim-toml.git'
Plug 'christoomey/vim-sort-motion.git'
Plug 'dhruvasagar/vim-table-mode.git'
Plug 'fatih/vim-go.git'
Plug 'inkarkat/argtextobj.vim.git'
Plug 'junegunn/vim-easy-align.git'
Plug 'kien/ctrlp.vim.git'
Plug 'mattn/emmet-vim.git'
Plug 'michaeljsmith/vim-indent-object.git'
Plug 'nathanaelkane/vim-indent-guides.git'
Plug 'ntpeters/vim-better-whitespace.git'
Plug 'othree/html5.vim.git'
Plug 'pangloss/vim-javascript.git'
Plug 'plasticboy/vim-markdown.git'
Plug 'scrooloose/nerdtree.git'
Plug 'tomasr/molokai.git'
Plug 'tpope/vim-abolish.git'
Plug 'tpope/vim-commentary.git'
Plug 'tpope/vim-eunuch.git'
Plug 'tpope/vim-fugitive.git'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating.git'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired.git'
Plug 'tyru/open-browser.vim.git'
Plug 'vim-latex/vim-latex.git'

if has('unix')
    Plug 'Valloric/YouCompleteMe.git', { 'do': './install.sh' }
    Plug 'marijnh/tern_for_vim', { 'do': 'npm update' }
    Plug 'scrooloose/syntastic.git', { 'do': 'sudo npm -g install jshint; sudo pip install pyflakes' }
endif

call plug#end()

" ctrlp.vim
let g:ctrlp_cmd = 'CtrlPMixed'

" syntastic
let g:syntastic_python_checkers = ['pyflakes']
let g:syntastic_always_populate_loc_list = 1

" vim-airline
let g:airline#extensions#tabline#enabled = 1

" vim-latex
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats = 'pdf, aux'

" vim-licenses
let g:licenses_authors_name = 'Alex Yatskov <alex@foosoft.net>'
let g:licenses_copyright_holders_name = g:licenses_authors_name

" vim-table-mode
let g:table_mode_corner = '|'
