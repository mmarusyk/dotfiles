#!/bin/bash

set -e

GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

CONFIG_DIR="$(pwd)/config/git"
GIT_CONFIG="$HOME/.gitconfig"

echo -e "${GREEN}\nInstalling Git...${RESET}"
sudo apt update -y
sudo apt install -y git

echo -e "${GREEN}\nSetting up Git configuration...${RESET}"

echo -e "${GREEN}Copying new gitconfig from $CONFIG_DIR...${RESET}"
cp -f "$CONFIG_DIR/gitconfig" "$GIT_CONFIG"

echo -e "${GREEN}Git installed and configuration set successfully!${RESET}"
