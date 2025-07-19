#!/bin/bash

set -e

CONFIG_DIR="${INSTALL_DIR}/config/alacritty"
HOME_CONFIG="$HOME/.config/alacritty"

if [[ "$OSTYPE" != "linux-gnu"* ]]; then
  echo -e "${YELLOW}Skipping Alacritty: not a Linux system (OSTYPE=$OSTYPE).${NC}"
  return 0 2>/dev/null || exit 0
fi

sudo apt update
sudo apt install -y alacritty

echo -e "${BLUE}Setting Alacritty as the default terminal...${RESET}"

sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty

echo -e "${BLUE}Setting up Alacritty configuration...${RESET}"

mkdir -p $HOME_CONFIG
cp -r $CONFIG_DIR/. $HOME_CONFIG
