call plug#begin('~/.vim/plugged')

Plug 'https://github.com/Chun-Yang/vim-action-ag.git'
Plug 'https://github.com/FooSoft/vim-argwrap.git'
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'https://github.com/antoyo/vim-licenses.git'
Plug 'https://github.com/b4winckler/vim-angry.git'
Plug 'https://github.com/bkad/CamelCaseMotion'
Plug 'https://github.com/cespare/vim-toml.git'
Plug 'https://github.com/christoomey/vim-sort-motion.git'
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
Plug 'https://github.com/derekwyatt/vim-fswitch.git'
Plug 'https://github.com/dhruvasagar/vim-table-mode.git'
Plug 'https://github.com/fatih/vim-go.git'
Plug 'https://github.com/junegunn/vim-easy-align.git'
Plug 'https://github.com/mattn/emmet-vim.git'
Plug 'https://github.com/michaeljsmith/vim-indent-object.git'
Plug 'https://github.com/moll/vim-bbye.git'
Plug 'https://github.com/nathanaelkane/vim-indent-guides.git'
Plug 'https://github.com/ntpeters/vim-better-whitespace.git'
Plug 'https://github.com/othree/html5.vim.git'
Plug 'https://github.com/pangloss/vim-javascript.git'
Plug 'https://github.com/plasticboy/vim-markdown.git'
Plug 'https://github.com/rking/ag.vim.git'
Plug 'https://github.com/rust-lang/rust.vim'
Plug 'https://github.com/schickling/vim-bufonly.git'
Plug 'https://github.com/tomasr/molokai.git'
Plug 'https://github.com/tpope/vim-abolish.git'
Plug 'https://github.com/tpope/vim-bundler.git'
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/tpope/vim-eunuch.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/tpope/vim-rails.git'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/tpope/vim-speeddating.git'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-unimpaired.git'
Plug 'https://github.com/tpope/vim-vinegar.git'
Plug 'https://github.com/tyru/open-browser.vim.git'
Plug 'https://github.com/vasconcelloslf/vim-interestingwords.git'
Plug 'https://github.com/vim-airline/vim-airline-themes.git'
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/vim-latex/vim-latex.git'

if has('unix')
    Plug 'https://github.com/Valloric/YouCompleteMe.git', { 'do': './install.sh --clang-completer' }
    Plug 'https://github.com/marijnh/tern_for_vim', { 'do': 'sudo npm install -g tern; npm install' }
    Plug 'https://github.com/scrooloose/syntastic.git', { 'do': 'sudo npm -g install eslint; sudo pip install --upgrade pyflakes' }
endif

call plug#end()

" ag.vim
let g:ag_working_path_mode="r"

" CamelCaseMotion
call camelcasemotion#CreateMotionMappings('<leader>')

" ctrlp.vim
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'ra'

" syntastic
auto FileType go let b:syntastic_mode = "passive"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_python_checkers = ['pyflakes']

" vim-airline
let g:airline#extensions#tabline#enabled = 1

" vim-argwrap
autocmd FileType go let b:argwrap_tail_comma = 1

" vim-gitgutter
let g:gitgutter_max_signs = 10000

" vim-go
let g:go_fmt_command = 'goimports'

" vim-licenses
let g:licenses_authors_name = 'Alex Yatskov <alex@foosoft.net>'
let g:licenses_copyright_holders_name = g:licenses_authors_name

" vim-rails
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1

" vim-table-mode
let g:table_mode_corner = '|'

" YouCompleteMe
let g:ycm_check_if_ycm_core_present = 0
let g:ycm_confirm_extra_conf = 0
