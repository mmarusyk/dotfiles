#
# More info about docker: https://docs.docker.com/engine/install/ubuntu/
# About docker compose: 
#

GREEN='\033[0;32m'
NC='\033[0m'

DIR=$(pwd)/ruby
BACKUP_DIR=$1


printf "$GREEN\nInstalling Docker...$NC\n"

# Set up the repository
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

# Install Docker Engine
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start Docker
sudo systemctl start docker

# To test
sudo docker run hello-world

printf "$GREEN\nSetup managing docker as a non-root user...$NC\n"
sudo groupadd docker
sudo usermod -aG docker $USER

printf "$GREEN\nPlease log out and log back to manage docker as a non-root user!$NC\n"

printf "$GREEN\nInstalling Docker Compose...$NC\n"
sudo yum update
sudo yum install docker-compose-plugin
docker compose version

#
#  Add: docker compose "$@" to: /bin/docker-compose (optional) with permission: chmod 755 /bin/docker-compose
#
