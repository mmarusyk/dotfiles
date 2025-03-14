#!/bin/bash

set -e

# Colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

echo -e "${GREEN}\nInstalling required dependencies for Slack...${RESET}"
sudo apt update -y
sudo apt install -y wget gdebi-core

SLACK_DEB="slack-desktop-4.41.105-amd64.deb"
SLACK_URL="https://downloads.slack-edge.com/desktop-releases/linux/x64/4.41.105/$SLACK_DEB"

echo -e "${GREEN}\nDownloading Slack...${RESET}"
wget -O "$SLACK_DEB" "$SLACK_URL"

echo -e "${GREEN}\nInstalling Slack...${RESET}"
sudo dpkg -i "$SLACK_DEB"

sudo apt --fix-broken install -y

echo -e "${GREEN}\nCleaning up...${RESET}"
rm -f "$SLACK_DEB"

if command -v slack &> /dev/null; then
    echo -e "${GREEN}Slack installed successfully!${RESET}"
else
    echo -e "${RED}Slack installation failed!${RESET}"
fi

echo -e "${YELLOW}\nSlack installation complete!${RESET}"
