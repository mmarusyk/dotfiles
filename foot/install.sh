GREEN='\033[0;32m'
NC='\033[0m'
DIR=$(pwd)/foot
BACKUP_DIR=$1
PATH_TO_CONFIG=~/.config/foot

if [ -z "$1" ]; then
  BACKUP_DIR=$(pwd)/backup_dotfiles/$(date +%Y%m%d_%H%M%S)
  mkdir $BACKUP_DIR -p
fi

if ! command -v foot >/dev/null 2>&1; then
  printf "$GREEN\nInstalling foot...$NC\n"
  sudo apt install -yq foot
fi

if [ ! -d $PATH_TO_CONFIG ]; then
  printf "$GREEN\nCreating config folder for foot...$NC\n"
  mkdir -p $PATH_TO_CONFIG
fi

printf "$GREEN\nUpdating foot config...$NC\n"
if [ -f $PATH_TO_CONFIG/foot.ini ]; then
  mv $PATH_TO_CONFIG/foot.ini $BACKUP_DIR
fi
ln -sf $DIR/foot.ini $PATH_TO_CONFIG/foot.ini


printf "$GREEN\nSet foot by default...$NC\n"
sudo update-alternatives --set x-terminal-emulator /usr/bin/foot
