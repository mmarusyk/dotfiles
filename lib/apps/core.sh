#!/usr/bin/env bash

custom_install_core() {
  case $DETECTED_OS in
    arch)
      run_cmd sudo pacman -Syu --noconfirm
      run_cmd sudo pacman -S --noconfirm base-devel git curl wget less brightnessctl
      if ! command -v yay &>/dev/null; then
        run_cmd git clone https://aur.archlinux.org/yay.git /tmp/yay
        (cd /tmp/yay && run_cmd makepkg -si --noconfirm)
        run_cmd rm -rf /tmp/yay
      fi
      run_cmd sudo pacman -S --noconfirm flatpak
      run_cmd sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      ;;
    ubuntu)
      run_cmd sudo apt-get update
      run_cmd sudo apt-get upgrade -y
      run_cmd sudo apt-get install -y build-essential git curl wget less
      _core_install_gum_ubuntu
      ;;
    macos)
      if ! command -v brew &>/dev/null; then
        if [[ "${DRY_RUN:-false}" == "true" ]]; then
          echo "[DRY RUN] /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        else
          /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
      fi
      run_cmd brew install git curl
      ;;
  esac
}

_core_install_gum_ubuntu() {
  command -v gum &>/dev/null && return
  run_cmd sudo apt-get install -y curl gpg
  run_cmd sudo mkdir -p /etc/apt/keyrings
  if [[ "${DRY_RUN:-false}" == "true" ]]; then
    echo "[DRY RUN] curl https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg"
    echo "[DRY RUN] echo 'deb ...' | sudo tee /etc/apt/sources.list.d/charm.list"
  else
    curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
    echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" \
      | sudo tee /etc/apt/sources.list.d/charm.list > /dev/null
  fi
  run_cmd sudo apt-get update
  run_cmd sudo apt-get install -y gum
}

custom_update_core() {
  case $DETECTED_OS in
    arch)   run_cmd sudo pacman -Syu --noconfirm ;;
    ubuntu) run_cmd sudo apt-get update && run_cmd sudo apt-get upgrade -y ;;
    macos)  run_cmd brew update && run_cmd brew upgrade ;;
  esac
}
