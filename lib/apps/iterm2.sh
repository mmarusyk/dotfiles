#!/usr/bin/env bash

_iterm2_guid="F8B2A1C3-4D5E-6F70-8192-A3B4C5D6E7F8"

config_iterm2() {
  local profiles_dir="$HOME/Library/Application Support/iTerm2/DynamicProfiles"
  run_cmd mkdir -p "$profiles_dir"
  run_cmd ln -sf "$ROOT_DIR/config/iterm2/dotfiles.json" "$profiles_dir/dotfiles.json"
  run_cmd defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "$_iterm2_guid"
}

custom_install_iterm2() {
  case $DETECTED_OS in
    macos)
      run_cmd brew install --cask iterm2
      config_iterm2
      ;;
    *) log_info "iTerm2 is macOS-only; skipping on $DETECTED_OS" ;;
  esac
}

custom_update_iterm2() {
  case $DETECTED_OS in
    macos) run_cmd brew upgrade --cask iterm2 ;;
    *)     log_info "iTerm2 is macOS-only; skipping on $DETECTED_OS" ;;
  esac
}

custom_destroy_iterm2() {
  case $DETECTED_OS in
    macos) run_cmd brew uninstall --cask iterm2 ;;
    *)     log_info "iTerm2 is macOS-only; skipping on $DETECTED_OS" ;;
  esac
}
