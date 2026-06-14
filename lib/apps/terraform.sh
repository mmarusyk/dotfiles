#!/usr/bin/env bash

custom_install_terraform() {
  run_cmd mise use -g terraform@latest
  run_cmd mise reshim
}

custom_update_terraform() {
  run_cmd mise use -g terraform@latest
  run_cmd mise reshim
}

custom_destroy_terraform() {
  run_cmd mise uninstall terraform
}
