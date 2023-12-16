#
# More info about docker: https://docs.docker.com/engine/install/ubuntu/
# About docker compose: 
#

GREEN='\033[0;32m'
NC='\033[0m'

DIR=$(pwd)/ruby
BACKUP_DIR=$1


printf "$GREEN\nInstalling Docker...$NC\n"

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
# !Change $VESION_CODENAME to lunar if package is not present

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# To test
# sudo docker run hello-world

printf "$GREEN\nSetup managing docker as a non-root user...$NC\n"
sudo groupadd docker
sudo usermod -aG docker $USER

printf "$GREEN\nPlease log out and log back to manage docker as a non-root user!$NC\n"

printf "$GREEN\nInstalling Docker Compose...$NC\n"
sudo apt-get update
sudo apt-get install docker-compose-plugin

#
#  Add: docker compose "$@" to: /bin/docker-compose (optional) with permission: chmod 755 /bin/docker-compose
#
