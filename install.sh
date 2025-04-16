#!/bin/bash

set -e

GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
RESET="\e[0m"

echo -e "${BLUE}Starting dotfiles installation...${RESET}"

INSTALL_DIR="$(cd "$(dirname "$0")" && pwd)"

# List of install scripts
SCRIPTS=(
  "fonts.sh"
  "alacritty.sh"
  "zsh.sh"
  "zellij.sh"
  "mise.sh"
  "vscode.sh"
  "git.sh"
  "docker.sh"
  "ruby.sh"
  "erlang.sh"
  "elixir.sh"
  "nodejs.sh"
  "libreoffice.sh"
  "slack.sh"
  "gimp.sh"
  "vlc.sh"
  "zoom.sh"
  "cursor.sh"
# TODO:
# "veracrypt.sh"
# "chrome.sh"
# "obsidian.sh"
# "pomodoro.sh"
)

for script in "${SCRIPTS[@]}"; do
  if [[ -f "$INSTALL_DIR/install/$script" ]]; then
    echo -e "${YELLOW}Running install/$script...${RESET}"
    bash "$INSTALL_DIR/install/$script"
    echo -e "${GREEN}$script installed successfully.${RESET}"
  else
    echo -e "${RED}Error: install/$script not found! Skipping...${RESET}"
  fi
done

echo -e "${GREEN}Dotfiles installation completed!${RESET}"
