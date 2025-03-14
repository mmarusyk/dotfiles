#!/bin/bash

set -e

GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

CONFIG_DIR="$(pwd)/config/zellij"
ZELLIJ_CONFIG_DIR="$HOME/.config/zellij"

echo -e "${GREEN}\nInstalling additional packages...${RESET}"
sudo apt update -y
sudo apt install -y build-essential

echo -e "${GREEN}\nInstalling Zellij...${RESET}"

echo -e "${GREEN}\nChecking if Cargo (Rust) is installed...${RESET}"

if ! command -v cargo &> /dev/null; then
    echo -e "${RED}Cargo (Rust) not found! Installing Rust...${RESET}"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env
    echo -e "${GREEN}Rust and Cargo installed successfully!${RESET}"
else
    echo -e "${GREEN}Cargo (Rust) is already installed.${RESET}"
fi

# Install Zellij via Cargo
echo -e "${GREEN}\nInstalling Zellij using Cargo...${RESET}"
cargo install zellij

echo -e "${GREEN}Zellij installed successfully!${RESET}"

echo -e "${GREEN}\nSetting up Zellij configuration...${RESET}"

mkdir -p "$ZELLIJ_CONFIG_DIR"

cp -r "$CONFIG_DIR/." "$ZELLIJ_CONFIG_DIR"

echo -e "${YELLOW}\nZellij installation and configuration complete.${RESET}"
