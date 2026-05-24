#!/usr/bin/env bash

config_tmux() {
  run_cmd mkdir -p "$HOME/.config/tmux"
  run_cmd ln -sf "$ROOT_DIR/config/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
}
