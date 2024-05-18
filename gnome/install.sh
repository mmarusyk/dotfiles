#! /bin/bash
GREEN='\033[0;32m'
NC='\033[0m'
DIR=$(pwd)/gnome
BACKUP_DIR=$1

if [ -z "$1" ]; then
  BACKUP_DIR=$(pwd)/backup_dotfiles/$(date +%Y%m%d_%H%M%S)
  mkdir $BACKUP_DIR -p
fi

dconf dump /org/gnome/ > $BACKUP_DIR/configs.dconf

dconf load /org/gnome/ < $DIR/configs.dconf

printf "$GREEN\nGnome config has been imported.$NC\n"
