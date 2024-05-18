call plug#begin('~/.config/nvim/plugged')
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

syntax on
set encoding=utf-8                                " Set the character encoding to UTF-8 for proper handling of Unicode characters
set mouse=a                                       " Enable mouse support in all modes (normal, insert, visual)
set nobackup                                      " Disable the creation of backup files (files ending with ~)
set noswapfile                                    " Disable the creation of swap files for buffer recovery
set number                                        " Display line numbers on the left side of the window
set relativenumber                                " Display line numbers relative to the current cursor position
set colorcolumn=120                               " Highlight the column at character position 120 for better code readability
set hidden                                        " Buffer switching without saving changes
set nocp                                          " Disable compatibility mode (vi compatibility)
set hlsearch                                      " Highlight searching

set grepprg=rg\ --vimgrep\ --smart-case\ --follow " When you run :grep, you will use this command

filetype plugin on                                " Enable filetype detection and plugins

" Silent file search and text search
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>

" Disable arrow navigation
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>
