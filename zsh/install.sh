#! /bin/bash

GREEN='\033[0;32m'
NC='\033[0m'
DIR=$(pwd)/zsh
BACKUP_DIR=$1

# Check if a backup directory argument is provided
if [ -z "$1" ]; then
  BACKUP_DIR=$(pwd)/backup_dotfiles/$(date +%Y%m%d_%H%M%S)
  mkdir -p "$BACKUP_DIR"
fi

# Check if zsh is installed
if ! command -v zsh >/dev/null 2>&1; then
  printf "$GREEN\nInstalling zsh...$NC\n"
  sudo apt update && sudo apt install -y zsh
fi

# Make zsh the default shell if it is not already
if [ "$SHELL" != "/usr/bin/zsh" ] && [ "$SHELL" != "/bin/zsh" ]; then
  printf "$GREEN\nMaking zsh the default shell...$NC\n"
  chsh -s "$(which zsh)"
fi

# Install oh-my-zsh if it is not already installed
if [ ! -d ~/.oh-my-zsh ]; then
  printf "$GREEN\nInstalling oh-my-zsh...$NC\n"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Update oh-my-zsh themes
if [ -f ~/.oh-my-zsh/themes/obraun-custom.zsh-theme ]; then
  printf "$GREEN\nUpdating oh-my-zsh themes...$NC\n"
  mv ~/.oh-my-zsh/themes/obraun-custom.zsh-theme "$BACKUP_DIR"
fi
ln -sf "$DIR/themes/obraun-custom.zsh-theme" ~/.oh-my-zsh/themes/obraun-custom.zsh-theme

# Update zsh configuration
printf "$GREEN\nUpdating zsh config...$NC\n"
if [ -f ~/.zshrc ]; then
  mv ~/.zshrc "$BACKUP_DIR"
fi
ln -sf "$DIR/zshrc" ~/.zshrc

# Update zsh aliases
printf "$GREEN\nUpdating zsh aliases...$NC\n"
if [ -f ~/.aliases.zsh ]; then
  mv ~/.aliases.zsh "$BACKUP_DIR"
fi
ln -sf "$DIR/aliases.zsh" ~/.aliases.zsh

printf "$GREEN\nZsh setup complete!$NC\n"
