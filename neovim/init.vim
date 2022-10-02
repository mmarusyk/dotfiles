call plug#begin()
Plug '907th/vim-auto-save'         " Functionality of automatically saving changed files
Plug 'airblade/vim-gitgutter'      " Shows a git diff in the sign column
Plug 'ap/vim-css-color'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'            " Plugin that provides viewing the tags of the current file
Plug 'ryanoasis/vim-devicons'      " Icons for NerdTree Plug 'tpope/vim-commentary'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'          " Parentheses, brackets, quotes, XML tags, and more
Plug 'vim-airline/vim-airline'

" Ruby on Rails plugins
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
call plug#end()

syntax on
set encoding=utf-8                  " The encoding displayed
set mouse=a
set nobackup
set noswapfile
set number
set relativenumber                 " Each line in your file is numbered relative to the cursor’s position
set colorcolumn=80

" Spaces & Tabs
set autoindent
set copyindent                     " copy indent from the previous line
set expandtab                      " tabs are space
set shiftwidth=2                   " number of spaces to use for autoindent
set smarttab
set softtabstop=2                  " number of spaces in tab when editing
set tabstop=2                      " number of visual spaces per TAB

let g:auto_save = 1                " Enable AutoSave on Vim startup
let g:auto_save_silent = 1         " Do not display the auto-save notification
let g:gitgutter_enabled = 1

colorscheme onedark

nnoremap <C-t> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>

let NERDTreeShowHidden=1

set tags+=.tags
nnoremap <leader>ct :silent ! ctags -R --languages=ruby --exclude=.git --exclude=log -f .tags<cr>
