#!/bin/bash

set -e  # Exit on error

# Colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

# Install GIMP
echo -e "${GREEN}\nInstalling GIMP...${RESET}"
sudo apt update -y
sudo apt install -y gimp

# Verify installation
if command -v gimp &> /dev/null; then
    echo -e "${GREEN}GIMP installed successfully!${RESET}"
else
    echo -e "${RED}GIMP installation failed!${RESET}"
fi

echo -e "${YELLOW}\nGIMP installation complete!${RESET}"
