#!/usr/bin/env bash

custom_install_obsidian() {
  case $DETECTED_OS in
    arch)   run_cmd sudo flatpak install -y flathub md.obsidian.Obsidian ;;
    ubuntu) run_cmd sudo snap install obsidian --classic ;;
    macos)  run_cmd brew install --cask obsidian ;;
  esac
}

custom_update_obsidian() {
  case $DETECTED_OS in
    arch)   run_cmd sudo flatpak update -y md.obsidian.Obsidian ;;
    ubuntu) run_cmd sudo snap refresh obsidian ;;
    macos)  run_cmd brew upgrade --cask obsidian ;;
  esac
}

custom_destroy_obsidian() {
  case $DETECTED_OS in
    arch)   run_cmd sudo flatpak uninstall -y md.obsidian.Obsidian ;;
    ubuntu) run_cmd sudo snap remove obsidian ;;
    macos)  run_cmd brew uninstall --cask obsidian ;;
  esac
}
