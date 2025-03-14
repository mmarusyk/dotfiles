#!/bin/bash

set -e  # Exit on error

# Colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

# Install VLC
echo -e "${GREEN}\nInstalling VLC media player...${RESET}"
sudo apt update -y
sudo apt install -y vlc

# Verify installation
if command -v vlc &> /dev/null; then
    echo -e "${GREEN}VLC installed successfully!${RESET}"
else
    echo -e "${RED}VLC installation failed!${RESET}"
fi

echo -e "${YELLOW}\nVLC installation complete!${RESET}"
