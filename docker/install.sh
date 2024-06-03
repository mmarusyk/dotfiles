#! /bin/bash

#
# More info about docker: https://docs.docker.com/engine/install/ubuntu/
# About docker compose: 
#

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

printf "$GREEN\nInstalling Docker Engine...$NC\n"

if command -v docker &> /dev/null; then
  printf "$YELLOW\nDocker is already installed.$NC\n"
else
  printf "$GREEN\nAdding Docker's official GPG key...$NC\n"
  sudo apt-get update
  sudo apt-get install ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  # Add the repository to Apt sources:
  printf "$GREEN\nAdding the repository to Apt sources...$NC\n"
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update

  printf "$GREEN\nInstalling the Docker latest version...$NC\n"
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  # Start Docker
  sudo systemctl start docker

  # To Test
  sudo docker run hello-world

  # Manage Docker as a non-root user
  sudo groupadd docker
  sudo usermod -aG docker $USER

  printf "$GREEN\nPlease log out and log back to manage docker as a non-root user!$NC\n"
fi

if command -v docker-compose &> /dev/null; then
  printf  "$YELLOW\nDocker Compose is already installed.$NC\n"
else
  printf "$GREEN\nInstalling Docker Compose...$NC\n"
  sudo apt-get update
  sudo apt-get install docker-compose-plugin
  docker compose version

  printf "$GREEN\nAdding docker compose to /bin/docker-compose...$NC\n"
  echo 'docker compose "$@"' | sudo tee -a /bin/docker-compose > /dev/null
  sudo chmod 755 /bin/docker-compose
fi

printf "Disable docker by default"
sudo systemctl disable docker.service
sudo systemctl disable docker.socket

systemctl list-unit-files | grep -i docker
