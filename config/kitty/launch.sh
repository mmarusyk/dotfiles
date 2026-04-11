#!/usr/bin/env bash
# Kitty launcher: starts Zellij if available, falls back to the default shell.
# Running through a login shell ensures PATH is fully populated before exec.
if command -v zellij &>/dev/null; then
  exec zellij
fi
exec "${SHELL:-/bin/zsh}"
