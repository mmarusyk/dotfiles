#!/usr/bin/env bash

custom_install_jetbrains_toolbox() {
  case $DETECTED_OS in
    ubuntu)
      run_cmd curl -Lo /tmp/jetbrains-toolbox.tar.gz \
        "https://data.services.jetbrains.com/products/download?platform=linux&code=TBA"
      run_cmd tar -xzf /tmp/jetbrains-toolbox.tar.gz -C /tmp
      if [[ "$DRY_RUN" != "true" ]]; then
        local dir
        dir=$(find /tmp -maxdepth 1 -type d -name 'jetbrains-toolbox-*' | head -n1)
        run_cmd "$dir/bin/jetbrains-toolbox"
        run_cmd rm -rf "$dir"
      fi
      run_cmd rm -f /tmp/jetbrains-toolbox.tar.gz
      ;;
    macos)
      run_cmd brew install --cask jetbrains-toolbox
      ;;
  esac
}

custom_update_jetbrains_toolbox() {
  case $DETECTED_OS in
    ubuntu) log_info "JetBrains Toolbox self-updates automatically." ;;
    macos)  run_cmd brew upgrade --cask jetbrains-toolbox ;;
  esac
}

custom_destroy_jetbrains_toolbox() {
  case $DETECTED_OS in
    ubuntu) run_cmd rm -f "$HOME/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox" ;;
    macos)  run_cmd brew uninstall --cask jetbrains-toolbox ;;
  esac
}
