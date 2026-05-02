#!/usr/bin/env bash

custom_install_ruby() {
  if [[ "$DETECTED_OS" == "arch" ]]; then
    run_cmd sudo pacman -S --noconfirm base-devel libffi libyaml openssl zlib readline
  fi
  run_cmd mise use -g ruby@latest
  run_cmd mise reshim
}

custom_update_ruby() {
  run_cmd mise use -g ruby@latest
  run_cmd mise reshim
}

custom_destroy_ruby() {
  run_cmd mise uninstall ruby
}
