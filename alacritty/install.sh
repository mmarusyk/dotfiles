#! /bin/bash

GREEN='\033[0;32m'
NC='\033[0m'
DIR=$(pwd)/alacritty
BACKUP_DIR=$1
PATH_TO_CONFIG=$HOME/.config/alacritty
CONFIG_NAME=alacritty.toml

# Check if a backup directory argument is provided
if [ -z "$1" ]; then
  BACKUP_DIR=$(pwd)/backup_dotfiles/$(date +%Y%m%d_%H%M%S)
  mkdir -p $BACKUP_DIR
fi

# Check if alacritty is installed
if ! command -v alacritty >/dev/null 2>&1; then
  printf "$GREEN\nInstalling alacritty...$NC\n"
  sudo pacman -Syu --noconfirm alacritty
fi

if [ ! -d $PATH_TO_CONFIG ]; then
  printf "$GREEN\nCreating config folder for alacritty...$NC\n"
  mkdir -p $PATH_TO_CONFIG
fi

printf "$GREEN\nUpdating alacritty config...$NC\n"
if [ -f $PATH_TO_CONFIG/$CONFIG_NAME ]; then
  mv $PATH_TO_CONFIG/$CONFIG_NAME $BACKUP_DIR
fi
ln -sf $DIR/$CONFIG_NAME $PATH_TO_CONFIG/$CONFIG_NAME
