#!/bin/bash

set -e

GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

echo -e "${YELLOW}Installing Iosevka fonts...${RESET}"

FONT_URL="http://phd-sid.ethz.ch/debian/fonts-iosevka/fonts-iosevka_22.0.0%2Bds-1_all.deb"
DEB_FILE="$HOME/fonts-iosevka.deb"

if ! command -v wget &> /dev/null; then
    echo -e "${YELLOW}Installing wget...${RESET}"
    sudo apt update
    sudo apt install -y wget
fi

echo -e "${YELLOW}Downloading Iosevka fonts .deb package...${RESET}"
wget -O "$DEB_FILE" "$FONT_URL"

echo -e "${YELLOW}Installing Iosevka fonts...${RESET}"
sudo dpkg -i "$DEB_FILE"

rm "$DEB_FILE"

echo -e "${YELLOW}Refreshing font cache...${RESET}"
sudo fc-cache -fv

echo -e "${GREEN}Iosevka fonts installed successfully!${RESET}"