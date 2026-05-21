#!/usr/bin/env bash

_rtk_ensure_local_bin_path() {
  local rc_file="$HOME/.zshrc"
  if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]] \
     && ! grep -q 'HOME/.local/bin' "$rc_file" 2>/dev/null; then
    if [[ "${DRY_RUN:-false}" == "true" ]]; then
      echo "[DRY RUN] echo 'export PATH=\"\$HOME/.local/bin:\$PATH\"' >> $rc_file"
    else
      echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$rc_file"
      log_info "Added ~/.local/bin to PATH in $rc_file — restart your shell or: source $rc_file"
    fi
  fi
}

custom_install_rtk() {
  if command -v rtk &>/dev/null; then
    log_info "rtk already installed ($(rtk --version 2>/dev/null | head -1))"
    return 0
  fi
  case $DETECTED_OS in
    macos) run_cmd brew install rtk ;;
    ubuntu)
      if [[ "${DRY_RUN:-false}" == "true" ]]; then
        echo "[DRY RUN] curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh"
      else
        curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh
      fi
      _rtk_ensure_local_bin_path
      ;;
  esac
  config_rtk
}

config_rtk() {
  link_config "$ROOT_DIR/config/rtk/config.toml" "$HOME/.config/rtk/config.toml"
  if ! command -v rtk &>/dev/null; then
    log_warn "rtk not found — skipping Claude Code hook setup"
    return 0
  fi
  run_cmd rtk init -g
}

custom_update_rtk() {
  case $DETECTED_OS in
    macos) run_cmd brew upgrade rtk ;;
    ubuntu)
      if [[ "${DRY_RUN:-false}" == "true" ]]; then
        echo "[DRY RUN] curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh"
      else
        curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh
      fi
      ;;
  esac
}

custom_destroy_rtk() {
  run_cmd rm -f "$HOME/.config/rtk/config.toml"
  case $DETECTED_OS in
    macos) run_cmd brew uninstall rtk ;;
    ubuntu) run_cmd rm -f "$HOME/.local/bin/rtk" ;;
  esac
}
