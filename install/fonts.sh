#!/bin/bash

set -e

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  sudo apt update
  sudo apt install -y fontconfig wget unzip
elif [[ "$OSTYPE" == "darwin"* ]]; then
  brew install fontconfig wget unzip
else
  echo -e "${RED}Unsupported OS: $OSTYPE${NC}"
  exit 1
fi

FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

if ! fc-list | grep -qi "Iosevka Nerd Font"; then
  echo -e "${YELLOW}Downloading and installing Iosevka Nerd Font...${NC}"
  cd /tmp
  wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Iosevka.zip -O Iosevka.zip
  unzip -q Iosevka.zip -d IosevkaFont
  cp IosevkaFont/*.ttf "$FONT_DIR"
  rm -rf Iosevka.zip IosevkaFont
  fc-cache -f
  echo -e "${GREEN}Iosevka Nerd Font installed successfully!${NC}"
else
  echo -e "${GREEN}Iosevka Nerd Font is already installed.${NC}"
fi
