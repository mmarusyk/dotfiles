#!/bin/bash

set -e

CONFIG_DIR="${INSTALL_DIR}/config/git"
GIT_CONFIG="$HOME/.gitconfig"

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  sudo apt update
  sudo apt install -y git
elif [[ "$OSTYPE" == "darwin"* ]]; then
  brew install git 
else
  echo -e "${RED}Unsupported OS: $OSTYPE${NC}"
  exit 1
fi

echo -e "${BLUE}Copying configuration...${NC}"
cp -f "$CONFIG_DIR/gitconfig" "$GIT_CONFIG"

echo -e "\n${BLUE}Configuring git user identification...${NC}"

if [[ -z "${DOTFILES_USER_NAME//[[:space:]]/}" ]] || [[ -z "${DOTFILES_USER_EMAIL//[[:space:]]/}" ]]; then
  source "$INSTALL_DIR/install/1-identification.sh"
fi

if [[ -n "${DOTFILES_USER_NAME//[[:space:]]/}" ]]; then
  git config --global user.name "$DOTFILES_USER_NAME"
fi

if [[ -n "${DOTFILES_USER_EMAIL//[[:space:]]/}" ]]; then
  git config --global user.email "$DOTFILES_USER_EMAIL"
fi

