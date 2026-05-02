#!/usr/bin/env bash

custom_install_fonts() {
  if fc-list | grep -qi "Iosevka Nerd Font"; then
    log_info "Iosevka Nerd Font already installed"
    return 0
  fi
  local version font_dir="$HOME/.local/share/fonts/IosevkaNerdFont"
  version=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest \
    | grep '"tag_name"' | sed 's/.*"tag_name": "\(.*\)".*/\1/')
  run_cmd mkdir -p "$font_dir"
  run_cmd curl -L \
    "https://github.com/ryanoasis/nerd-fonts/releases/download/${version}/Iosevka.tar.xz" \
    -o /tmp/Iosevka.tar.xz
  run_cmd tar -xf /tmp/Iosevka.tar.xz -C "$font_dir"
  run_cmd rm /tmp/Iosevka.tar.xz
  run_cmd fc-cache -f "$font_dir"
}

custom_destroy_fonts() {
  run_cmd rm -rf "$HOME/.local/share/fonts/IosevkaNerdFont"
  run_cmd fc-cache -f
}
