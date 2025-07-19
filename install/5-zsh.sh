#!/bin/bash

set -e

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt update
    sudo apt install -y curl zsh
elif [[ "$OSTYPE" == "darwin"* ]]; then
  brew install curl zsh
else
  echo -e "${RED}Unsupported OS: $OSTYPE${NC}"
  exit 1
fi

ZSH_PATH=$(which zsh || echo "/bin/zsh")
chsh -s "$ZSH_PATH"

echo -e "${GREEN}Zsh installed and set as the default shell successfully!${NC}"

echo -e "${BLUE}Installing Oh My Zsh...${NC}"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    echo -e "${GREEN}Oh My Zsh installed successfully!${NC}"
else
    echo -e "${YELLOW}Oh My Zsh is already installed!${NC}"
fi

echo -e "${YELLOW}Updating Zsh themes...${NC}"

THEME_DIR="$HOME/.oh-my-zsh/custom/themes"

if [ -d "$INSTALL_DIR/themes/zsh" ]; then
    cp -r "$INSTALL_DIR/themes/zsh/"* "$THEME_DIR/"
    echo -e "${GREEN}Zsh themes updated successfully!${NC}"
else
    echo -e "${RED}No themes found to update.${NC}"
fi

echo -e "${GREEN}\nUpdating Zsh config...${NC}"

cp "$INSTALL_DIR/config/zsh/zshrc" $HOME/.zshrc
echo -e "${GREEN}Zsh config updated successfully!${NC}"

echo -e "${GREEN}\nUpdating Zsh aliases...${NC}"

cp "$INSTALL_DIR/config/zsh/aliases.zsh" $HOME/.aliases.zsh

echo -e "${GREEN}Zsh aliases updated successfully!${NC}"
