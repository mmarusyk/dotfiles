#!/bin/bash

set -e

CONFIG_DIR="${INSTALL_DIR}/config/zellij"
HOME_CONFIG_DIR="$HOME/.config/zellij"

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  sudo apt update -y
  sudo apt install -y build-essential
elif [[ "$OSTYPE" == "darwin"* ]]; then
  brew install curl
else
    echo -e "${RED}Unsupported OS: $OSTYPE${NC}"
    exit 1
fi

echo -e "${BLUE}\nChecking if Cargo (Rust) is installed...${NC}"

if ! command -v cargo &> /dev/null; then
    echo -e "${RED}Cargo (Rust) not found! Installing Rust...${NC}"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    export PATH="$HOME/.cargo/bin:$PATH"

    echo -e "${GREEN}Rust and Cargo installed successfully!${NC}"
else
    echo -e "${YELLOW}Cargo (Rust) is already installed.${NC}"
fi

# Install Zellij via Cargo
echo -e "${BLUE}\nInstalling Zellij using Cargo...${NC}"
cargo install zellij

echo -e "${GREEN}Zellij installed successfully!${NC}"

echo -e "${BLUE}\nSetting up Zellij configuration...${NC}"

mkdir -p "$HOME_CONFIG_DIR"

cp -r "$CONFIG_DIR/." "$HOME_CONFIG_DIR"
