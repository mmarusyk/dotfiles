GREEN='\033[0;32m'
NC='\033[0m'
DIR=$(pwd)/neovim
BACKUP_DIR=$1
PATH_TO_CONFIG=~/.config/nvim

if [ -z "$1" ]; then
  BACKUP_DIR=$(pwd)/backup_dotfiles/$(date +%Y%m%d_%H%M%S)
  mkdir $BACKUP_DIR -p
fi

if ! command -v nvim >/dev/null 2>&1; then
  printf "$GREEN\nInstalling neovim...$NC\n"
	sudo apt-get install -yqq neovim

  printf "$GREEN\nInstalling plugin manager...$NC"
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

if [ ! -d $PATH_TO_CONFIG ]; then
  printf "$GREEN\nCreating config folder for neovim...$NC\n"
  mkdir -p $PATH_TO_CONFIG
fi

printf "$GREEN\nUpdating veovim config...$NC\n"
if [ -f $PATH_TO_CONFIG/init.vim ]; then
  mv $PATH_TO_CONFIG/init.vim $BACKUP_DIR
fi
ln -sf $DIR/init.vim $PATH_TO_CONFIG/init.vim

printf "$GREEN\nInstalling plugins...$NC"
nvim --headless +PlugInstall +qall
