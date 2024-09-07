GREEN='\033[0;32m'
NC='\033[0m'
RUBY_VERSION='3.3.5'
DIR=$(pwd)/ruby
BACKUP_DIR=$1

if ! command -v ruby >/dev/null 2>&1; then
  printf "$GREEN\nInstalling Ruby $RUBY_VERSION...$NC\n"

  asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
  asdf install ruby $RUBY_VERSION
  asdf global ruby $RUBY_VERSION
fi


printf "$GREEN\nInstalling Ruby Gems...$NC\n"
gem install bundler
gem install rails
gem install awesome_print

if [ -z "$1" ]; then
  BACKUP_DIR=$(pwd)/backup_dotfiles/$(date +%Y%m%d_%H%M%S)
  mkdir $BACKUP_DIR -p
fi

printf "$GREEN\nUpdating irbrc config...$NC\n"
if [ -f ~/.irbrc ]; then
  mv ~/.irbrc $BACKUP_DIR
fi
ln -sf $DIR/irbrc ~/.irbrc
