#!/bin/bash

set -e

if ! command -v mise &> /dev/null; then
    echo -e "${RED}Mise is not installed! Please install Mise first.${NC}"
    exit 1
fi

echo -e "${YELLOW}\nInstalling the latest LTS version of Node.js...${NC}"
mise use -g node@lts
mise reshim

echo -e "${YELLOW}\nInstalling Yarn globally...${NC}"
npm install -g yarn
