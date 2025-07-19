#!/bin/bash

set -e

if ! command -v mise &> /dev/null; then
    echo -e "${RED}Mise is not installed! Please install Mise first.${NC}"
    exit 1
fi

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  echo -e "${YELLOW}\nInstalling required dependencies...${NC}"
  sudo apt update -y
  sudo apt install -y build-essential
fi

echo -e "${GREEN}\nInstalling the latest Erlang version via Mise...${NC}"
mise use -g erlang

echo -e "${GREEN}\nInstalling the latest Elixir version via Mise...${NC}"
mise use -g elixir
