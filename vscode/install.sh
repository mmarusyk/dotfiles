#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m'
DIR="$(pwd)/vscode"
CONFIG_DIR="$HOME/.config/Code/User"
BACKUP_DIR="$1"

if [ -z "$1" ]; then
  BACKUP_DIR="$(pwd)/backup_dotfiles/$(date +%Y%m%d_%H%M%S)"
  mkdir -p "$BACKUP_DIR"
fi

if ! command -v code >/dev/null 2>&1; then
  printf "${GREEN}\nInstalling vscode...${NC}\n"
  sudo snap install code
fi

if [ ! -d "$CONFIG_DIR" ]; then
  printf "${GREEN}\nCreating config folder for vscode...${NC}\n"
  mkdir -p "$CONFIG_DIR"
fi

printf "${GREEN}\nUpdating vscode config...${NC}\n"
if [ -f "$CONFIG_DIR/settings.json" ]; then
  mv "$CONFIG_DIR/settings.json" "$BACKUP_DIR"
fi
ln -sf "$DIR/settings.json" "$CONFIG_DIR/settings.json"

printf "${GREEN}\nInstalling vscode plugins...${NC}\n"
code --install-extension aaron-bond.better-comments
code --install-extension aliariff.vscode-erb-beautify
code --install-extension amazonwebservices.aws-toolkit-vscode
code --install-extension ms-vscode-remote.remote-containers
code --install-extension shopify.ruby-extensions-pack
code --install-extension vscodevim.vim
code --install-extension vscode-icons-team.vscode-icons
