GREEN='\033[0;32m'
NC='\033[0m'
DIR=$(pwd)/zsh
BACKUP_DIR=$1

if [ -z "$1" ]; then
  BACKUP_DIR=$(pwd)/backup_dotfiles/$(date +%Y%m%d_%H%M%S)
  mkdir $BACKUP_DIR -p
fi

if ! command -v zsh >/dev/null 2>&1; then
  printf "$GREEN\nInstalling zsh...$NC\n"
	sudo apt-get install -yqq zsh
fi

if [ "$SHELL" != "/usr/bin/zsh" -a "$SHELL" != "/bin/zsh" ]; then
  printf "$GREEN\nMaking zsh by default...$NC\n"
  chsh -s $(which zsh)
fi

if [ ! -d ~/.oh-my-zsh ]; then
  printf "$GREEN\nInstalling oh-my-zsh...$NC\n"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

if [ -f ~/.oh-my-zsh/themes/obraun-custom.zsh-theme ]; then
  printf "$GREEN\nUpdating oh-my-zsh themes...$NC\n"
  mv ~/.oh-my-zsh/themes/obraun-custom.zsh-theme $BACKUP_DIR
fi
ln -sf $DIR/themes/obraun-custom.zsh-theme ~/.oh-my-zsh/themes/obraun-custom.zsh-theme

printf "$GREEN\nUpdating zsh config...$NC\n"
if [ -f ~/.zshrc ]; then
  mv ~/.zshrc $BACKUP_DIR
fi
ln -sf $DIR/zshrc ~/.zshrc

