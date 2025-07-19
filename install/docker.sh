#!/bin/bash

set -e

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  if ! command -v docker &>/dev/null; then
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl gnupg lsb-release

    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    sudo systemctl start docker
    sudo docker run hello-world || true

    sudo groupadd docker || true
    sudo usermod -aG docker "$USER"
  fi

  if ! docker compose version &>/dev/null; then
    echo -e "${YELLOW}Installing Docker Compose plugin on Ubuntu...${NC}"
    sudo apt-get install -y docker-compose-plugin
  fi

elif [[ "$OSTYPE" == "darwin"* ]]; then
  if ! command -v docker &>/dev/null; then
    brew install --cask docker
  fi
else
  echo -e "${RED}Unsupported OS: $OSTYPE${NC}"
  exit 1
fi
