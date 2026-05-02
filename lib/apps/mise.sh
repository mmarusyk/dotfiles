#!/usr/bin/env bash

custom_install_mise() {
  if command -v mise &>/dev/null; then
    log_info "mise already installed"
    return 0
  fi
  case $DETECTED_OS in
    arch|macos) pkg_install mise ;;
    ubuntu)
      if [[ "${DRY_RUN:-false}" == "true" ]]; then
        echo "[DRY RUN] curl https://mise.run | sh"
      else
        curl https://mise.run | sh
      fi
      ;;
  esac
}

custom_update_mise() {
  run_cmd mise self-update
}

custom_destroy_mise() {
  run_cmd rm -f "$HOME/.local/bin/mise"
  case $DETECTED_OS in
    arch|macos) pkg_destroy mise ;;
  esac
}
