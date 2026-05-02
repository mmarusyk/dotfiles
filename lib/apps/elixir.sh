#!/usr/bin/env bash

custom_install_elixir() {
  run_cmd mise use -g erlang
  run_cmd mise use -g elixir
  run_cmd mise reshim
}

custom_update_elixir() {
  run_cmd mise use -g erlang
  run_cmd mise use -g elixir
  run_cmd mise reshim
}

custom_destroy_elixir() {
  run_cmd mise uninstall elixir
  run_cmd mise uninstall erlang
}
