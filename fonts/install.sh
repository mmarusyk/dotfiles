#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'
DOWNLOAD_URL="https://rubjo.github.io/victor-mono/VictorMonoAll.zip"
DESTINATION_DIR="$HOME/.local/share/fonts/victor-mono"

printf "$GREEN\nInstalling Iosevka font...$NC\n"
sudo pacman -S --noconfirm ttc-iosevka
