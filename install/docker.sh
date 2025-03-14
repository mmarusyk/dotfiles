#!/bin/bash

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "$GREEN\nInstalling Docker Engine...$NC\n"

if command -v docker &> /dev/null; then
  echo -e "$YELLOW\nDocker is already installed.$NC\n"
else
  # Add Docker's official GPG key:
  sudo apt-get update
  sudo apt-get install ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update

  # Install docker
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  # Start Docker service
  sudo systemctl start docker

  # To Test
  sudo docker run hello-world

  # Manage Docker as a non-root user
  sudo groupadd docker
  sudo usermod -aG docker "$USER"

  echo -e "$GREEN\nPlease log out and log back in to manage Docker as a non-root user!$NC\n"
fi

if command -v docker-compose &> /dev/null; then
  echo -e "$YELLOW\nDocker Compose is already installed.$NC\n"
else
  # Install Docker Compose
  echo -e "$GREEN\nInstalling Docker Compose...$NC\n"
  sudo apt-get update
  sudo apt-get install -y docker-compose-plugin
  docker compose version

  echo -e "$GREEN\nAdding docker compose to /bin/docker-compose...$NC\n"
  echo 'docker compose "$@"' | sudo tee -a /bin/docker-compose > /dev/null
  sudo chmod 755 /bin/docker-compose
fi

# Optionally disable Docker service
echo -e "$GREEN\nDisabling Docker by default...$NC\n"
sudo systemctl disable docker.service
sudo systemctl disable docker.socket

# List Docker unit files
systemctl list-unit-files | grep -i docker
