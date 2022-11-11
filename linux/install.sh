GREEN='\033[0;32m'
NC='\033[0m'
YELLOW='\033[0;33m'
DIR=$(pwd)/linux
BACKUP_DIR=$1

printf "$GREEN\nSetting up resolution...$NC\n"

if [ -z "$1" ]; then
  BACKUP_DIR=$(pwd)/backup_dotfiles/$(date +%Y%m%d_%H%M%S)
  mkdir $BACKUP_DIR -p
fi

if [ -f ~/.xprofile ]; then
  mv ~/.xprofile $BACKUP_DIR
fi

ln -sf $DIR/xprofile ~/.xprofile

printf "$YELLOW\nChanges was applied after reboot system$NC\n"
