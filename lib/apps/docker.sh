#!/usr/bin/env bash

custom_install_docker() {
  case $DETECTED_OS in
    arch|ubuntu)
      if command -v podman &>/dev/null; then
        log_info "podman already installed"
      else
        pkg_install podman
      fi
      ;;
    macos)
      if command -v docker &>/dev/null; then
        log_info "docker already installed"
      else
        run_cmd brew install colima docker docker-compose docker-buildx
        run_cmd colima start
      fi
      ;;
  esac
}

custom_update_docker() {
  case $DETECTED_OS in
    arch)   run_cmd sudo pacman -S --noconfirm podman ;;
    ubuntu) run_cmd sudo apt-get install --only-upgrade -y podman ;;
    macos)  run_cmd brew upgrade colima docker ;;
  esac
}

custom_destroy_docker() {
  case $DETECTED_OS in
    arch)   run_cmd sudo pacman -Rns --noconfirm podman ;;
    ubuntu) run_cmd sudo apt-get remove -y podman ;;
    macos)
      run_cmd colima stop
      run_cmd brew uninstall colima docker docker-compose docker-buildx
      ;;
  esac
}
