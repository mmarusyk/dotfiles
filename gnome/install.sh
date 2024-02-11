#! /bin/bash
GREEN='\033[0;32m'
NC='\033[0m'
DIR=$(pwd)/gnome

# dconf dump /org/gnome/ > gnome/configs.dconf
dconf load /org/gnome/ < $DIR/configs.dconf

printf "$GREEN\nGnome config has been imported.$NC\n"
