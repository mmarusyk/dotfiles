#!/usr/bin/env bash

_zellij_latest_url() {
  local arch version
  arch=$(uname -m)
  version=$(curl -s https://api.github.com/repos/zellij-org/zellij/releases/latest \
    | grep '"tag_name"' | sed 's/.*"tag_name": "\(.*\)".*/\1/')
  echo "https://github.com/zellij-org/zellij/releases/download/${version}/zellij-${arch}-unknown-linux-musl.tar.gz"
}

custom_install_zellij() {
  if command -v zellij &>/dev/null; then
    log_info "zellij already installed ($(zellij --version))"
    return 0
  fi
  case $DETECTED_OS in
    arch|macos) pkg_install zellij ;;
    ubuntu)
      run_cmd curl -L "$(_zellij_latest_url)" -o /tmp/zellij.tar.gz
      run_cmd tar -xzf /tmp/zellij.tar.gz -C /tmp
      run_cmd sudo mv /tmp/zellij /usr/local/bin/zellij
      run_cmd rm -f /tmp/zellij.tar.gz
      ;;
  esac
  config_zellij
}

config_zellij() {
  run_cmd mkdir -p "$HOME/.config/zellij"
  run_cmd ln -sf "$ROOT_DIR/config/zellij/config.kdl" "$HOME/.config/zellij/config.kdl"
}

custom_update_zellij() {
  local current latest
  current=$(zellij --version 2>/dev/null | awk '{print $2}')
  latest=$(curl -s https://api.github.com/repos/zellij-org/zellij/releases/latest \
    | grep '"tag_name"' | sed 's/.*"tag_name": "\(.*\)".*/\1/')
  if [[ "v${current}" == "${latest}" ]]; then
    log_info "zellij already up to date (${latest})"
    return 0
  fi
  case $DETECTED_OS in
    arch|macos) pkg_update zellij ;;
    ubuntu)
      run_cmd curl -L "$(_zellij_latest_url)" -o /tmp/zellij.tar.gz
      run_cmd tar -xzf /tmp/zellij.tar.gz -C /tmp
      run_cmd sudo mv /tmp/zellij /usr/local/bin/zellij
      run_cmd rm -f /tmp/zellij.tar.gz
      ;;
  esac
}

custom_destroy_zellij() {
  run_cmd rm -f "$HOME/.config/zellij/config.kdl"
  case $DETECTED_OS in
    arch|macos) pkg_destroy zellij ;;
    ubuntu)     run_cmd sudo rm -f /usr/local/bin/zellij ;;
  esac
}
