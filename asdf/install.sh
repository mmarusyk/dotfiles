GREEN='\033[0;32m'
NC='\033[0m'
ASDF_VERSION='v0.14.0'

if [ ! -d ~/.asdf ]; then
  printf "$GREEN\nCloning asdf...$NC\n"
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch $ASDF_VERSION
  
  exec $SHELL
fi
