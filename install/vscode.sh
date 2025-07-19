#!/bin/bash

set -e

CONFIG_DIR=$(pwd)/config/vscode

if [[ "$OSTYPE" == "darwin"* ]]; then
  HOME_DIR="$HOME/Library/Application Support/Code/User"
else
  HOME_DIR="$HOME/.config/Code/User"
fi

if ! command -v code &> /dev/null; then
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections

        sudo apt-get install wget gpg
        wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
        sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
        echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
        rm -f packages.microsoft.gpg

        sudo apt install apt-transport-https
        sudo apt update
        sudo apt install -y code
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install --cask visual-studio-code
    else
        echo -e "${RED}Unsupported OS: $OSTYPE${NC}"
        exit 1
    fi
else
    echo -e "${YELLOW}Visual Studio Code is already installed.${NC}"
fi

if ! command -v code &> /dev/null; then
  echo -e "${RED}Visual Studio Code installation failed!${NC}"
  exit 1
fi

code --install-extension aaron-bond.better-comments
code --install-extension aliariff.vscode-erb-beautify
code --install-extension amazonwebservices.aws-toolkit-vscode
code --install-extension ms-vscode-remote.remote-containers
code --install-extension shopify.ruby-extensions-pack
code --install-extension vscodevim.vim
code --install-extension vscode-icons-team.vscode-icons
code --install-extension github.copilot-chat

echo -e "${GREEN}Copying new settings.json from $DIR...${NC}"
cp -f "$CONFIG_DIR/settings.json" "$HOME_DIR/settings.json"
