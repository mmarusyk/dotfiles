GREEN='\033[0;32m'
NC='\033[0m'
DIR=$(pwd)/git
BACKUP_DIR=$1

if ! command -v git >/dev/null 2>&1; then
  printf "$GREEN\nInstalling git...$NC\n"
	sudo apt-get install -yqq git
fi

printf "$GREEN\nUpdating gitconfig config...$NC\n"
if [ -f ~/.gitconfig ]; then
  mv ~/.gitconfig $BACKUP_DIR
fi
ln -sf $DIR/gitconfig ~/.gitconfig

printf "$GREEN\nUpdating gitignore config...$NC\n"
if [ -f ~/.gitignore ]; then
  mv ~/.gitignore $BACKUP_DIR
fi
ln -sf $DIR/gitignore ~/.gitignore
