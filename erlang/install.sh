GREEN='\033[0;32m'
NC='\033[0m'
ERLANG_VERSION='27.0.1'
DIR=$(pwd)/erlang
BACKUP_DIR=$1

if ! command -v erl >/dev/null 2>&1; then
  printf "$GREEN\nInstalling Erlang $ERLANG_VERSION...$NC\n"

  asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
  asdf install erlang $ERLANG_VERSION
  asdf global erlang $ERLANG_VERSION
fi