#! /bin/bash

#
# More info about docker: https://docs.docker.com/engine/install/ubuntu/
# About docker compose: 
#

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

if command -v docker &> /dev/null; then
  printf "$YELLOW\nDocker is already installed.$NC\n"
else
  printf "$GREEN\nInstalling the dnf-plugins-core package and set up the repository...$NC\n"

  sudo dnf -yq install dnf-plugins-core
  sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

  printf "$GREEN\nInstalling Docker...$NC\n"

  # Install Docker Engine
  sudo dnf -yq install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  # Start Docker
  sudo systemctl start docker

  # To test
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
  sudo yum -y update
  sudo yum -y install docker-compose-plugin
  docker compose version

  printf "$GREEN\nAdd docker compose "$@" to /bin/docker-compose...$NC\n"
  echo 'docker compose "$@"' | sudo tee -a /bin/docker-compose > /dev/null
  sudo chmod 755 /bin/docker-compose
fi
