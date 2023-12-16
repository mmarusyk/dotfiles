#! /bin/bash

# Consts
GREEN='\033[0;32m'
NC='\033[0m'
BACKUP_DIR=$(pwd)/backup_dotfiles/$(date +%Y%m%d_%H%M%S)

# Delete configs carefully!
# Some configs have dependencies and order matters.
CONFIGS=(
  "software"
  # "linux"
  "docker"
  "git"
  "zsh"
  "tmux"
  "asdf"
  "ruby"
  "nodejs"
  "vscode"
  "neovim"
)

# Create backup directory for storing old configs
mkdir $BACKUP_DIR -p

for config in ${CONFIGS[@]}; do
  script_path="./$config/fedora.install.sh"

  if [ -f "$script_path" ]; then
    "$script_path" "$BACKUP_DIR"
  else
    "./$config/install.sh" "$BACKUP_DIR"
  fi
done

printf "$GREEN\n\nDONE$NC\n\n"
