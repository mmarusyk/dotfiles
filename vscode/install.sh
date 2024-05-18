GREEN='\033[0;32m'
NC='\033[0m'
DIR=$(pwd)/vscode
CONFIG_DIR=~/.var/app/com.visualstudio.code/config/Code/User
BACKUP_DIR=$1

if [ -z "$1" ]; then
  BACKUP_DIR=$(pwd)/backup_dotfiles/$(date +%Y%m%d_%H%M%S)
  mkdir $BACKUP_DIR -p
fi

if ! command -v flatpak run com.visualstudio.code >/dev/null 2>&1; then
  printf "$GREEN\nInstalling vscode...$NC\n"
  sudo flatpak install com.visualstudio.code
fi

if [ ! -d $CONFIG_DIR ]; then
  printf "$GREEN\nCreating config folder for vscode...$NC\n"
  mkdir -p $CONFIG_DIR
fi

printf "$GREEN\nUpdating vscode config...$NC\n"
if [ -f $CONFIG_DIR/settings.json ]; then
  mv $CONFIG_DIR/settings.json $BACKUP_DIR
fi
ln -sf $DIR/settings.json $CONFIG_DIR/settings.json

printf "$GREEN\nInstalling vscode plugins...$NC\n"
flatpak run com.visualstudio.code --install-extension aaron-bond.better-comments
flatpak run com.visualstudio.code --install-extension aliariff.vscode-erb-beautify
flatpak run com.visualstudio.code --install-extension eamodio.gitlens
flatpak run com.visualstudio.code --install-extension github.copilot
flatpak run com.visualstudio.code --install-extension github.copilot-chat
flatpak run com.visualstudio.code --install-extension ms-vscode.vscode-speech
flatpak run com.visualstudio.code --install-extension shopify.ruby-extensions-pack
flatpak run com.visualstudio.code --install-extension s-nlf-fh.glassit
flatpak run com.visualstudio.code --install-extension vscodevim.vim
flatpak run com.visualstudio.code --install-extension vscode-icons-team.vscode-icons
