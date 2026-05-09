#!/usr/bin/env bash

custom_install_fonts() {
  detect_os
  if fc-list | grep -qi "Iosevka Nerd Font"; then
    log_info "Iosevka Nerd Font already installed"
    return 0
  fi
  local version font_dir SUDO
  case "$DETECTED_OS" in
    ubuntu)
      font_dir="/usr/share/fonts/IosevkaNerdFont"
      SUDO=sudo
      ;;
    *)
      font_dir="$HOME/.local/share/fonts/IosevkaNerdFont"
      SUDO=""
      ;;
  esac
  version=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest \
    | grep '"tag_name"' | sed 's/.*"tag_name": \"\(.*\)\".*/\1/')
  run_cmd $SUDO mkdir -p "$font_dir"
  run_cmd curl -L \
    "https://github.com/ryanoasis/nerd-fonts/releases/download/${version}/Iosevka.tar.xz" \
    -o /tmp/Iosevka.tar.xz
  run_cmd $SUDO tar -xf /tmp/Iosevka.tar.xz -C "$font_dir"
  run_cmd $SUDO rm /tmp/Iosevka.tar.xz
  run_cmd $SUDO fc-cache -f "$font_dir"
}

custom_destroy_fonts() {
  detect_os
  case "$DETECTED_OS" in
    ubuntu)
      run_cmd sudo rm -rf "/usr/share/fonts/IosevkaNerdFont"
      run_cmd sudo fc-cache -f
      ;;
    *)
      run_cmd rm -rf "$HOME/.local/share/fonts/IosevkaNerdFont"
      run_cmd fc-cache -f
      ;;
  esac
}
