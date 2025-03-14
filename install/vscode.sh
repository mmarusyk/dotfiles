#!/bin/bash

set -e

INSTALL_DIR=$(pwd)/config/vscode
CONFIG_DIR=$HOME/.config/Code/User

GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

echo -e "${GREEN}\nInstalling Visual Studio Code...${RESET}"

echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections

sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg

sudo apt install apt-transport-https
sudo apt update
sudo apt install code

if command -v code &> /dev/null; then
    echo -e "${GREEN}Visual Studio Code installed successfully!${RESET}"
else
    echo -e "${RED}Visual Studio Code installation failed!${RESET}"
fi

code --install-extension aaron-bond.better-comments
code --install-extension aliariff.vscode-erb-beautify
code --install-extension amazonwebservices.aws-toolkit-vscode
code --install-extension ms-vscode-remote.remote-containers
code --install-extension shopify.ruby-extensions-pack
code --install-extension vscodevim.vim
code --install-extension vscode-icons-team.vscode-icons
code --install-extension github.copilot-chat

echo -e "${GREEN}Copying new settings.json from $DIR...${RESET}"
cp -f "$INSTALL_DIR/settings.json" "$CONFIG_DIR/settings.json"


echo -e "${YELLOW}\nVisual Studio Code installation complete!${RESET}"
