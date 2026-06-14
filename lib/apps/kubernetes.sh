#!/usr/bin/env bash

custom_install_kubernetes() {
  run_cmd mise use -g kubectl@latest
  run_cmd mise use -g helm@latest
  run_cmd mise use -g minikube@latest
  run_cmd mise use -g k9s@latest
  run_cmd mise reshim
}

custom_update_kubernetes() {
  run_cmd mise use -g kubectl@latest
  run_cmd mise use -g helm@latest
  run_cmd mise use -g minikube@latest
  run_cmd mise use -g k9s@latest
  run_cmd mise reshim
}

custom_destroy_kubernetes() {
  run_cmd mise uninstall kubectl
  run_cmd mise uninstall helm
  run_cmd mise uninstall minikube
  run_cmd mise uninstall k9s
}
