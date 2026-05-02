#!/usr/bin/env bash

custom_install_chrome() {
  case $DETECTED_OS in
    arch) run_cmd yay -S --noconfirm --needed google-chrome ;;
    ubuntu)
      if command -v google-chrome-stable &>/dev/null; then
        log_info "Google Chrome already installed"
        return 0
      fi
      local tmp
      tmp=$(mktemp --suffix=.deb)
      run_cmd wget -O "$tmp" https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
      run_cmd sudo apt-get install -y "$tmp"
      run_cmd rm -f "$tmp"
      ;;
    macos) run_cmd brew install --cask google-chrome ;;
  esac
}

custom_update_chrome() {
  case $DETECTED_OS in
    arch)   run_cmd yay -S --noconfirm google-chrome ;;
    ubuntu) custom_install_chrome ;;
    macos)  run_cmd brew upgrade --cask google-chrome ;;
  esac
}

custom_destroy_chrome() {
  case $DETECTED_OS in
    arch)   run_cmd yay -Rns --noconfirm google-chrome ;;
    ubuntu) run_cmd sudo apt-get remove -y google-chrome-stable ;;
    macos)  run_cmd brew uninstall --cask google-chrome ;;
  esac
}
