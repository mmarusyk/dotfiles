GREEN='\033[0;32m'
NC='\033[0m'
RUBY_VERSION='3.1.2'

if ! command -v ruby >/dev/null 2>&1; then
  printf "$GREEN\nInstalling Ruby $RUBY_VERSION...$NC\n"

  asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
  asdf install ruby $RUBY_VERSION
  asdf global ruby $RUBY_VERSION

  gem install bundler
  gem install rails
  gem install rubocop
fi
