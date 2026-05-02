#!/usr/bin/env bash

custom_install_zsh() {
  pkg_install zsh

  local zsh_path
  zsh_path=$(command -v zsh)
  if [[ "$DETECTED_OS" == "macos" ]]; then
    run_cmd chsh -s "$zsh_path"
  else
    run_cmd sudo chsh -s "$zsh_path" "$USER"
  fi

  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    if [[ "${DRY_RUN:-false}" == "true" ]]; then
      echo "[DRY RUN] sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\" -- --unattended"
    else
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
  fi

  config_zsh
}

config_zsh() {
  local theme_dir="$HOME/.oh-my-zsh/custom/themes"
  run_cmd mkdir -p "$theme_dir"
  for f in "$ROOT_DIR/themes/zsh/"*; do
    run_cmd ln -sf "$f" "$theme_dir/$(basename "$f")"
  done
  run_cmd ln -sf "$ROOT_DIR/config/zsh/zshrc"      "$HOME/.zshrc"
  run_cmd ln -sf "$ROOT_DIR/config/zsh/aliases.zsh" "$HOME/.aliases.zsh"
}

custom_destroy_zsh() {
  run_cmd rm -f "$HOME/.zshrc" "$HOME/.aliases.zsh"
  run_cmd rm -rf "$HOME/.oh-my-zsh"
  pkg_destroy zsh
}
