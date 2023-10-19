GREEN='\033[0;32m'
NC='\033[0m'
DIR=$(pwd)/vscode
BACKUP_DIR=$1

if [ -z "$1" ]; then
  BACKUP_DIR=$(pwd)/backup_dotfiles/$(date +%Y%m%d_%H%M%S)
  mkdir $BACKUP_DIR -p
fi

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
ln -df $DIR/settings.json ~/.config/Code/User/settings.json

printf "$GREEN\nInstalling vscode plugins...$NC\n"
code --install-extension aaron-bond.better-comments
code --install-extension bradlc.vscode-tailwindcss
code --install-extension castwide.solargraph
code --install-extension donjayamanne.githistory
code --install-extension eamodio.gitlens
code --install-extension esbenp.prettier-vscode
code --install-extension hridoy.rails-snippets
code --install-extension misogi.ruby-rubocop
code --install-extension miguel-savignano.ruby-symbols
code --install-extension shopify.ruby-lsp
code --install-extension sianglim.slim
code --install-extension vscodevim.vim
code --install-extension vscode-icons-team.vscode-icons
