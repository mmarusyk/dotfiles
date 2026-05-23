#!/usr/bin/env bash

custom_install_dotnet() {
  run_cmd mise use -g dotnet@10
  run_cmd mise reshim
}

custom_update_dotnet() {
  run_cmd mise use -g dotnet@10
  run_cmd mise reshim
}

custom_destroy_dotnet() {
  run_cmd mise uninstall dotnet
}
