# My dotfiles repository

## Installation
```
git clone https://github.com/mmarusyk/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```
This will install:
* Necessery software:
  * curl
  * git
  * zsh
  * tmux
  * vim
* Custom dotfiles
  * zsh
  * tmux
  * vim

## Docs
* [Git Cheat Sheet](docs/git.md)
* [Vim Cheat Sheet](docs/vim.md)
* [Vim Plugins](docs/vim-plugins.md)
* [Tmux Cheat Sheet](docs/tmux.md)
* [Oh-my-zsh alias](docs/oh-my-zsh.md)

## ToDo
[ - ] Add ctags

VSCODE
1. sudo apt install ctags
2. Use extenssion: https://marketplace.visualstudio.com/items?itemName=jaydenlin.ctags-support
3. For generating tags file:
```
gem install ripper-tags
ripper-tags -R --exclude=vendor --exclude=chef --extra=q --tag-file=.tags
```
4. Shortcuts: Ctrl+Alt+G - got to definition, Ctrl+Shift+T - history

[ - ] Add tmux config

[ - ] Add vs code config
