#!/bin/bash

set -e

GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

echo -e "${GREEN}\nInstalling Zoom...${RESET}"

ZOOM_DEB="zoom_amd64.deb"
ZOOM_URL="https://zoom.us/client/latest/$ZOOM_DEB"

echo -e "${GREEN}\nDownloading Zoom...${RESET}"
wget -O "$ZOOM_DEB" "$ZOOM_URL"

echo -e "${GREEN}\nInstalling Zoom...${RESET}"
sudo apt install -y ./$ZOOM_DEB

echo -e "${GREEN}\nCleaning up...${RESET}"
rm -f "$ZOOM_DEB"

if command -v zoom &> /dev/null; then
    echo -e "${GREEN}Zoom installed successfully!${RESET}"
else
    echo -e "${RED}Zoom installation failed!${RESET}"
fi

echo -e "${YELLOW}\nZoom installation complete!${RESET}"
