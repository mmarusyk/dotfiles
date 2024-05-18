GREEN='\033[0;32m'
NC='\033[0m'
DIR=$(pwd)/tmux
BACKUP_DIR=$1

if [ -z "$1" ]; then
  BACKUP_DIR=$(pwd)/backup_dotfiles/$(date +%Y%m%d_%H%M%S)
  mkdir $BACKUP_DIR -p
fi

if ! command -v tmux >/dev/null 2>&1; then
  printf "$GREEN\nInstalling tmux...$NC\n"
  sudo apt -yq install tmux
fi


if [ ! -d ~/.tmux/plugins/tpm ]; then
  printf "$GREEN\nCloning tmux manager...$NC\n"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

printf "$GREEN\nUpdating tmux config...$NC\n"
if [ -f ~/.tmux.conf ]; then
  mv ~/.tmux.conf $BACKUP_DIR
fi
ln -sf $DIR/tmux.conf ~/.tmux.conf

printf "$GREEN\nReloading tmux configs...$NC\n"
tmux source ~/.tmux.conf

printf "$GREEN\nInstalling tmux plugins...$NC\n"
~/.tmux/plugins/tpm/bin/install_plugins
