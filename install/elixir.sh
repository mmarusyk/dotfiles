#!/bin/bash

set -e  # Exit on error

# Colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

echo -e "${GREEN}\nInstalling Elixir via Mise...${RESET}"

if ! command -v mise &> /dev/null; then
    echo -e "${RED}Mise is not installed! Please install Mise first.${RESET}"
    exit 1
fi

echo -e "${GREEN}\nInstalling the latest Elixir version via Mise...${RESET}"
mise use -g elixir

echo -e "${YELLOW}\nElixir installation complete!${RESET}"
