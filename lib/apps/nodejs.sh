#!/usr/bin/env bash

custom_install_nodejs() {
  run_cmd mise use -g node@lts
  run_cmd mise reshim
  run_cmd npm install -g yarn
}

custom_update_nodejs() {
  run_cmd mise use -g node@lts
  run_cmd mise reshim
  run_cmd npm update -g
}

custom_destroy_nodejs() {
  run_cmd mise uninstall node
}
