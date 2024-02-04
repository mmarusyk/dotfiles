GREEN='\033[0;32m'
NC='\033[0m'
NODEJS_VERSION='20.11.0'

if ! command -v node >/dev/null 2>&1; then
  printf "$GREEN\nInstalling Node.js $NODEJS_VERSION...$NC\n"

  asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  asdf install nodejs $NODEJS_VERSION
  asdf global nodejs $NODEJS_VERSION
fi

if ! command -v yarn >/dev/null 2>&1; then
  printf "$GREEN\nInstalling yarn...$NC\n"

  npm install --global yarn
fi
