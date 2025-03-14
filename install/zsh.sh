#!/bin/bash

set -e

INSTALL_DIR=$(pwd)

GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

echo -e "${YELLOW}Installing additional packages...${RESET}"
sudo apt update
sudo apt install -y curl

echo -e "${YELLOW}Installing Zsh and setting it as the default shell...${RESET}"

sudo apt install -y zsh

chsh -s $(which zsh)

echo -e "${GREEN}Zsh installed and set as the default shell successfully!${RESET}"

echo -e "${YELLOW}Installing Oh My Zsh...${RESET}"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo -e "${GREEN}Oh My Zsh is already installed!${RESET}"
fi

echo -e "${GREEN}Oh My Zsh installed successfully!${RESET}"

echo -e "${YELLOW}Updating Zsh themes...${RESET}"

THEME_DIR="$HOME/.oh-my-zsh/custom/themes"

if [ -d "$INSTALL_DIR/themes/zsh" ]; then
    cp -r "$INSTALL_DIR/themes/zsh/"* "$THEME_DIR/"
    echo -e "${GREEN}Zsh themes updated successfully!${RESET}"
else
    echo -e "${RED}No themes found to update.${RESET}"
fi

echo -e "${GREEN}\nUpdating Zsh config...${RESET}"

cp "$INSTALL_DIR/config/zsh/zshrc" $HOME/.zshrc
echo -e "${GREEN}Zsh config updated successfully!${RESET}"

echo -e "${GREEN}\nUpdating Zsh aliases...${RESET}"

cp "$INSTALL_DIR/config/zsh/aliases.zsh" $HOME/.aliases.zsh

echo -e "${GREEN}Zsh aliases updated successfully!${RESET}"

echo -e "${GREEN}Zsh setup completed successfully!${RESET}"
