#!/bin/bash

set -e

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  sudo apt update -y
  sudo apt install -y gpg sudo wget curl

  echo -e "${BLUE}Adding Mise repository and key...${NC}"

  sudo install -dm 755 /etc/apt/keyrings
  wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/mise-archive-keyring.gpg > /dev/null

  echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=amd64] https://mise.jdx.dev/deb stable main" \
    | sudo tee /etc/apt/sources.list.d/mise.list > /dev/null

  sudo apt update
  sudo apt install -y mise

elif [[ "$OSTYPE" == "darwin"* ]]; then
  brew install mise
else
  echo -e "${RED}Unsupported OS: $OSTYPE${NC}"
  exit 1
fi

exit 0
