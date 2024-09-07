#! /bin/bash

#
# More info about docker: https://wiki.archlinux.org/title/Docker
# About docker compose: https://docs.docker.com/compose/
#

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

printf "$GREEN\nInstalling Docker Engine...$NC\n"

if command -v docker &> /dev/null; then
  printf "$YELLOW\nDocker is already installed.$NC\n"
else
  # Update the system
  sudo pacman -Syu --noconfirm

  # Install Docker
  printf "$GREEN\nInstalling Docker...$NC\n"
  sudo pacman -S --noconfirm docker

  # Start Docker service
  sudo systemctl start docker
  sudo systemctl enable docker

  # To Test
  sudo docker run hello-world

  # Manage Docker as a non-root user
  sudo groupadd docker
  sudo usermod -aG docker $USER

  printf "$GREEN\nPlease log out and log back in to manage Docker as a non-root user!$NC\n"
fi

if command -v docker-compose &> /dev/null; then
  printf "$YELLOW\nDocker Compose is already installed.$NC\n"
else
  # Install Docker Compose
  printf "$GREEN\nInstalling Docker Compose...$NC\n"
  sudo pacman -S --noconfirm docker-compose

  # Check Docker Compose version
  docker-compose version
fi

# Optionally disable Docker service
printf "$GREEN\nDisabling Docker by default...$NC\n"
sudo systemctl disable docker.service
sudo systemctl disable docker.socket

# List Docker unit files
systemctl list-unit-files | grep -i docker
