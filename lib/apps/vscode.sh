#!/usr/bin/env bash

custom_install_vscode() {
  if ! command -v code &>/dev/null; then
    case $DETECTED_OS in
      arch) run_cmd yay -S --noconfirm --needed visual-studio-code-bin ;;
      ubuntu) run_cmd sudo snap install code --classic ;;
      macos) run_cmd brew install --cask visual-studio-code ;;
    esac
  fi
  config_vscode
}

config_vscode() {
  local dir="$HOME/.config/Code/User"
  run_cmd mkdir -p "$dir"
  run_cmd ln -sf "$ROOT_DIR/config/vscode/settings.json" "$dir/settings.json"
  for ext in vscodevim.vim anthropic.claude-code; do
    if ! code --list-extensions 2>/dev/null | grep -q "$ext"; then
      run_cmd code --install-extension "$ext"
    fi
  done
}

custom_update_vscode() {
  case $DETECTED_OS in
    arch)   run_cmd yay -S --noconfirm visual-studio-code-bin ;;
    ubuntu) run_cmd sudo snap refresh code ;;
    macos)  run_cmd brew upgrade --cask visual-studio-code ;;
  esac
}

custom_destroy_vscode() {
  case $DETECTED_OS in
    arch)   run_cmd yay -Rns --noconfirm visual-studio-code-bin ;;
    ubuntu) run_cmd sudo snap remove code ;;
    macos) run_cmd brew uninstall --cask visual-studio-code ;;
  esac
}
