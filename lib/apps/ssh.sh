#!/usr/bin/env bash

custom_install_ssh() {
  local key="$HOME/.ssh/id_ed25519"
  if [[ -f "$key" ]]; then
    log_info "SSH key already exists at $key"
    return 0
  fi
  run_cmd ssh-keygen -t ed25519 -C "${DOTFILES_USER_EMAIL:-user@example.com}" -f "$key" -N ""
}

custom_destroy_ssh() {
  run_cmd rm -f "$HOME/.ssh/id_ed25519" "$HOME/.ssh/id_ed25519.pub"
}
