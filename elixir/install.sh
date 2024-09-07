GREEN='\033[0;32m'
NC='\033[0m'
ELIXIR_VERSION='1.17'
DIR=$(pwd)/elixir
BACKUP_DIR=$1

if ! command -v elixir >/dev/null 2>&1; then
  printf "$GREEN\nInstalling Elixir $ELIXIR_VERSION...$NC\n"

  asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
  asdf install elixir $ELIXIR_VERSION
  asdf global elixir $ELIXIR_VERSION
fi