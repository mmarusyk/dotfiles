#! /bin/bash

GREEN='\033[0;32m'
NC='\033[0m'
DIR=$(pwd)/tmux
BACKUP_DIR=$1

# Check if a backup directory argument is provided
if [ -z "$1" ]; then
  BACKUP_DIR=$(pwd)/backup_dotfiles/$(date +%Y%m%d_%H%M%S)
  mkdir -p $BACKUP_DIR
fi

# Check if tmux is installed
if ! command -v tmux >/dev/null 2>&1; then
  printf "$GREEN\nInstalling tmux...$NC\n"
  sudo pacman -Syu --noconfirm tmux
fi

# Clone tmux plugin manager if not already present
if [ ! -d ~/.tmux/plugins/tpm ]; then
  printf "$GREEN\nCloning tmux plugin manager...$NC\n"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Update tmux configuration
printf "$GREEN\nUpdating tmux config...$NC\n"
if [ -f ~/.tmux.conf ]; then
  mv ~/.tmux.conf $BACKUP_DIR
fi
ln -sf $DIR/tmux.conf ~/.tmux.conf

# Reload tmux configuration
printf "$GREEN\nReloading tmux configs...$NC\n"
tmux source ~/.tmux.conf

# Install tmux plugins
printf "$GREEN\nInstalling tmux plugins...$NC\n"
~/.tmux/plugins/tpm/bin/install_plugins

printf "$GREEN\nTmux setup complete!$NC\n"
