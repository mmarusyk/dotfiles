set nocompatible               " be iMproved, required
filetype off                   " required

syntax enable                  " enable syntax highlighting

set encoding=utf-8             " open file with encoding
set fileencoding=utf-8         " save file with encoding
set nobackup                   " do not keep backup files
set noswapfile                 " do not write intermediate swap files
set nowrap                     " don't wrap lines
set colorcolumn=80             " show the line to wrap the long line by myself
set number                     " display line numbers on the left
set cursorline                 " highlight current line
set cursorcolumn               " highlight current column
set noerrorbells               " don't beep
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

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'preservim/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-ruby/vim-ruby'

call vundle#end()
filetype plugin indent on

hi CursorLine cterm=None ctermbg=237
hi CursorColumn cterm=None ctermbg=239
hi ColorColumn ctermbg=52

set tags+=$HOME/.rbenv/versions/3.0.0/lib/ruby/3.0.0/

