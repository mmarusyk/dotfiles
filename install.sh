#!/bin/bash

set -e

export INSTALL_DIR="$(pwd)"

source "$INSTALL_DIR/bin/colors.sh"

echo -e "\n${BLUE}Starting dotfiles installation...${NC}"

source "$INSTALL_DIR/bin/menu.sh"