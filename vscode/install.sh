GREEN='\033[0;32m'
NC='\033[0m'
DIR=$(pwd)/vscode
BACKUP_DIR=$1

if ! command -v code >/dev/null 2>&1; then
  printf "$GREEN\nInstalling vscode...$NC\n"
  sudo snap install code --classic
fi

if [ ! -d ~/.config/Code/User ]; then
  printf "$GREEN\nCreating config folder for vscode...$NC\n"
  mkdir -p ~/.config/Code/User
fi

printf "$GREEN\nUpdating vscode config...$NC\n"
if [ -f ~/.config/Code/User/settings.json ]; then
  mv ~/.config/Code/User/settings.json $BACKUP_DIR
fi
ln -df vscode/settings.json ~/.config/Code/User/settings.json

printf "$GREEN\nInstalling vscode plugins...$NC\n"
code --install-extension vscodevim.vim
code --install-extension vscode-icons-team.vscode-icons
