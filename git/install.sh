#! /bin/bash

GREEN='\033[0;32m'
NC='\033[0m'
DIR=$(pwd)/git
BACKUP_DIR=$1

# Check if a backup directory argument is provided
if [ -z "$1" ]; then
  BACKUP_DIR=$(pwd)/backup_dotfiles/$(date +%Y%m%d_%H%M%S)
  mkdir -p "$BACKUP_DIR"
fi

# Check if git is installed
if ! command -v git >/dev/null 2>&1; then
  printf "$GREEN\nInstalling git...$NC\n"
  sudo apt update && sudo apt install -y git
fi

# Update gitconfig configuration
printf "$GREEN\nUpdating gitconfig config...$NC\n"
if [ -f ~/.gitconfig ]; then
  mv ~/.gitconfig "$BACKUP_DIR"
fi
ln -sf "$DIR/gitconfig" ~/.gitconfig

# Update gitignore configuration
printf "$GREEN\nUpdating gitignore config...$NC\n"
if [ -f ~/.gitignore ]; then
  mv ~/.gitignore "$BACKUP_DIR"
fi
ln -sf "$DIR/gitignore" ~/.gitignore
