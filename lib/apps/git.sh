#!/usr/bin/env bash

custom_install_git() {
  pkg_install git
  config_git
}

config_git() {
  run_cmd ln -sf "$ROOT_DIR/config/git/gitconfig" "$HOME/.gitconfig"
  if [[ -n "${DOTFILES_USER_NAME:-}" ]]; then
    run_cmd git config --file "$HOME/.gitconfig.local" user.name "$DOTFILES_USER_NAME"
  fi
  if [[ -n "${DOTFILES_USER_EMAIL:-}" ]]; then
    run_cmd git config --file "$HOME/.gitconfig.local" user.email "$DOTFILES_USER_EMAIL"
  fi
}

custom_destroy_git() {
  run_cmd rm -f "$HOME/.gitconfig" "$HOME/.gitconfig.local"
}
