#!/bin/bash

set -e  # Exit on error

# Colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

echo -e "${GREEN}\nInstalling Ruby via Mise...${RESET}"

if ! command -v mise &> /dev/null; then
    echo -e "${RED}Mise is not installed! Please install Mise first.${RESET}"
    exit 1
fi

echo -e "${YELLOW}\nInstalling required dependencies...${RESET}"
sudo apt update -y
sudo apt install -yq curl \
  git-core \
  zlib1g-dev \
  build-essential \
  libssl-dev \
  libreadline-dev \
  libyaml-dev \
  libsqlite3-dev \
  sqlite3 \
  libxml2-dev \
  libxslt1-dev \
  libcurl4-openssl-dev \
  software-properties-common \
  libffi-dev \
  libpq-dev

echo -e "${GREEN}\nInstalling the latest Ruby version via Mise...${RESET}"
mise use -g ruby

echo -e "${YELLOW}\nRuby installation complete!${RESET}"
