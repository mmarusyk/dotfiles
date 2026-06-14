#!/usr/bin/env bash

custom_install_azure_cli() {
  case $DETECTED_OS in
    macos) pkg_install azure-cli ;;
    ubuntu)
      if [[ "${DRY_RUN:-false}" == "true" ]]; then
        echo "[DRY RUN] curl -fsSL 'https://azurecliprod.blob.core.windows.net/\$root/deb_install.sh' | sudo bash"
      else
        curl -fsSL 'https://azurecliprod.blob.core.windows.net/$root/deb_install.sh' | sudo bash
      fi
      ;;
  esac
}

custom_update_azure_cli() {
  run_cmd az upgrade --yes
}

custom_destroy_azure_cli() {
  case $DETECTED_OS in
    macos)  pkg_destroy azure-cli ;;
    ubuntu) run_cmd sudo apt-get remove -y azure-cli ;;
  esac
}
