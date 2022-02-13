# My dotfiles repository

## Installation

**Warning:** If you want use this dotfiles, you should first review the code and remove things that you don't want have.
```
git clone https://github.com/mmarusyk/dotfiles.git && cd dotfiles && ./install.sh
```
## Necessery software
### Installation git
```sudo apt install git```

### Installation vim
1. Install vim```sudo apt install vim```
2. Install vim-plug follow [this link](https://github.com/junegunn/vim-plug).
3. Reload .vimrc and ```:PlugInstall```

### Installation zsh
1. Install zsh: ```sudo apt install zsh```
2. Install oh-my-zsh follow [this link](https://github.com/ohmyzsh/ohmyzsh).

### Installation tmux
1. Install tmux: ```sudo apt install tmux```
2. clone Tmux Plugin Manager: git clone ```https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm```
3. Install plugins: ```~/.tmux/plugins/tpm/bin/install_plugins```
4. User Middle Mouse Button to paste text into another app.

### Installation RubyMine
1. install rubymine: ```sudo snap install mine --classic```
2. Tools -> Create command-line launcher -> OK
3. Install Plugins:
  3.1. VIM

### Installation VSCode (unused)
1. Istall vscode: ```sudo snap install code --classic```
2. Install extensions:
   1. CTags Support
   2. GitLens
   3. Vim
   4. Ruby
   5. ruby-rubocop
   6. Markdown All in One
