call plug#begin()

Plug 'ap/vim-css-color'
Plug 'mg979/vim-visual-multi'
Plug 'vim-airline/vim-airline'
Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rbenv'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'vim-ruby/vim-ruby'

call plug#end()

:set number
:set relativenumber
:set autoindent
:set tabstop=2
:set shiftwidth=2
:set smarttab
:set softtabstop=2
:set mouse=a
:set nobackup
:set noswapfile

syntax on
colorscheme onedark

nnoremap <C-t> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>

let NERDTreeShowHidden=1

set tags+=.tags
nnoremap <leader>ct :silent ! ctags -R --languages=ruby --exclude=.git --exclude=log -f .tags<cr>
