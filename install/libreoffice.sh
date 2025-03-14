#!/bin/bash

set -e

GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

echo -e "${GREEN}\nInstalling LibreOffice...${RESET}"
sudo apt update -y
sudo apt install -y libreoffice

if command -v libreoffice &> /dev/null; then
    echo -e "${GREEN}LibreOffice installed successfully!${RESET}"
else
    echo -e "${RED}LibreOffice installation failed!${RESET}"
fi

echo -e "${YELLOW}\nLibreOffice installation complete!${RESET}"
