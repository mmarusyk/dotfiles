set nocompatible               " be improved, required
filetype off                   " required

syntax enable                  " enable syntax highlighting

filetype plugin indent on      " recognize the typ of the file
filetype on                    " load th file ftplugin.vim in runtimepath
filetype indent on             " load the file indent.vim in runtimepath

set encoding=utf-8             " open file with encoding
set fileencoding=utf-8         " save file with encoding

set nobackup                   " do not keep backup files
set noswapfile                 " do not write intermediate swap files

" set nowrap                     " don't wrap lines

set colorcolumn=80             " show the line to wrap the long line by myself
set number                     " display line numbers on the left
set cursorline                 " highlight current line
set cursorcolumn               " highlight current column
set noerrorbells               " don't beep
" set novisualbell
set ruler                      " always show current position
set mouse=a                    " enable using the mouse if terminal emulator supports it
set hlsearch                   " highlight matches
set incsearch                  " incremental searching
set ignorecase                 " searches are case insensitive
set smartcase                  " unless they contain at least one capital letter

set tabstop=2                  " (ts) width (in spaces) that a <tab> is displayed as
set softtabstop=2              " when hitting <BS>, pretend like a tab is removed, even if spaces
set shiftwidth=2               " (sw) width (in spaces) used in each step of autoindent (aswell as << and >>)
set expandtab                  " (et) expand tabs to spaces (use :retab to redo entire file)
set smarttab                   " use shiftwidth to enter tabs
set autoindent                 " automatically indent to match adjacent lines
set smartindent

" set tags+=gems.tags              " ctags or
set tags=./tags;                 " ctags

" leader
let mapleader=","

" plugins
call plug#begin('~/.vim/plugged')
  Plug 'preservim/nerdtree'
  Plug 'vim-ruby/vim-ruby'
  Plug 'tpope/vim-rails'
  Plug 'junegunn/fzf'
  Plug 'tpope/vim-fugitive'
  Plug 'majutsushi/tagbar'
  Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

filetype plugin indent on

hi CursorLine cterm=None ctermbg=237
hi CursorColumn cterm=None ctermbg=239
hi ColorColumn ctermbg=52

" ctags Plugin
map <Leader>.z :CtrlPTag<CR>
nmap <C-t> :TagbarToggle<CR>
map <Leader>.t :ta /^

" NERDTree Plugin
map <C-n> :NERDTreeToggle<CR>

let NERDTreeShowHidden=1

" fugitive Plugin
map <Leader>.s :Gstatus<CR>
map <Leader>.b :Gblame<CR>
map <Leader>.w :Gbrowse<CR>
map <Leader>.d :Gdiff<CR>
set diffopt+=vertical

" ctrlpvim
let g:ctrlp_custom_ignore = 'node_modules\||.git\||bin\||Gemfile.lock'
