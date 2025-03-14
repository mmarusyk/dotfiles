#!/bin/bash

set -e  # Exit on error

# Colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

echo -e "${GREEN}\nInstalling Node.js LTS via Mise...${RESET}"

if ! command -v mise &> /dev/null; then
    echo -e "${RED}Mise is not installed! Please install Mise first.${RESET}"
    exit 1
fi

echo -e "${YELLOW}\nInstalling the latest LTS version of Node.js...${RESET}"
mise use -g node@lts

if command -v node &> /dev/null; then
    NODE_VERSION=$(node -v)
    echo -e "${GREEN}Node.js installed successfully! Version: ${NODE_VERSION}${RESET}"
else
    echo -e "${RED}Node.js installation failed!${RESET}"
    exit 1
fi

echo -e "${YELLOW}\nInstalling Yarn globally...${RESET}"
npm install -g yarn

echo -e "${YELLOW}\nNode.js installation complete!${RESET}"
