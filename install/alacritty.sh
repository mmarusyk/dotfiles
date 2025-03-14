#!/bin/bash

set -e

INSTALL_DIR=$(pwd)/config/alacritty
CONFIG_DIR=$HOME/.config/alacritty

GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

echo -e "${YELLOW}Installing Alacritty...${RESET}"

sudo apt update

sudo apt install -y alacritty

echo -e "${GREEN}Alacritty installed successfully!${RESET}"

echo -e "${YELLOW}Setting Alacritty as the default terminal...${RESET}"

sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty

echo -e "${GREEN}Alacritty set as the default terminal successfully!${RESET}"

echo -e "${YELLOW}Setting up Alacritty configuration...${RESET}"

mkdir -p $CONFIG_DIR
cp -r $INSTALL_DIR/. $CONFIG_DIR

echo -e "${GREEN}Alacritty configuration set up successfully!${RESET}"
