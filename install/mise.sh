#!/bin/bash

set -e

GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

echo -e "${GREEN}\nInstalling required dependencies...${RESET}"

sudo apt update -y
sudo apt install -y gpg sudo wget curl

echo -e "${GREEN}\nAdding Mise repository and key...${RESET}"

sudo install -dm 755 /etc/apt/keyrings
wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/mise-archive-keyring.gpg 1> /dev/null
echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=amd64] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list

echo -e "${GREEN}\nUpdating package list and installing Mise...${RESET}"

sudo apt update
sudo apt install -y mise

echo -e "${GREEN}Mise installed successfully!${RESET}"
echo -e "${YELLOW}\nPlease, close and open new terminal to continue installing.${RESET}"
exit 1