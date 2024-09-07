#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'
BACKUP_DIR=$(pwd)/backup_dotfiles/$(date +%Y%m%d_%H%M%S)

DEFAULT_CONFIGS=(
  "alacritty"
  "software"
  "gnome"
  "fonts"
  "docker"
  "git"
  "zsh"
  "tmux"
  "asdf"
  "ruby"
  "nodejs"
  "erlang"
  "elixir"
  "vscode"
  "neovim"
)

# Determine which configs to use
if [ "$#" -eq 0 ]; then
  CONFIGS=("${DEFAULT_CONFIGS[@]}")
else
  CONFIGS=("$@")
fi

# Create backup directory for storing old configs
mkdir -p "$BACKUP_DIR"

# Check if all scripts exist
for config in "${CONFIGS[@]}"; do
  script_path="./$config/install.sh"

  if [ ! -f "$script_path" ]; then
    printf "${RED}Error: No install script found for $config.${NC}\n"
    exit 1
  fi
done

# Run install scripts
for config in "${CONFIGS[@]}"; do
  script_path="./$config/install.sh"

  printf "${GREEN}Running $script_path...${NC}\n"
  "$script_path" "$BACKUP_DIR"
done

printf "${GREEN}\n\nDONE${NC}\n\n"
