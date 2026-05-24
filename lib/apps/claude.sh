#!/usr/bin/env bash

_claude_ensure_local_bin_path() {
  local rc_file="$HOME/.zshrc"
  if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]] \
     && ! grep -q 'HOME/.local/bin' "$rc_file" 2>/dev/null; then
    if [[ "${DRY_RUN:-false}" == "true" ]]; then
      echo "[DRY RUN] echo 'export PATH=\"\$HOME/.local/bin:\$PATH\"' >> $rc_file"
    else
      echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$rc_file"
      log_info "Added ~/.local/bin to PATH in $rc_file — restart your shell or: source $rc_file"
    fi
  fi
}

custom_install_claude() {
  if command -v claude &>/dev/null; then
    log_info "Claude CLI already installed ($(claude --version 2>/dev/null | head -1))"
    return 0
  fi
  if [[ "${DRY_RUN:-false}" == "true" ]]; then
    echo "[DRY RUN] curl -fsSL https://claude.ai/install.sh | bash"
  else
    curl -fsSL https://claude.ai/install.sh | bash
  fi
  _claude_ensure_local_bin_path
  config_claude
}

config_claude() {
  link_config "$ROOT_DIR/config/claude/settings.json" "$HOME/.claude/settings.json"
  link_config "$ROOT_DIR/config/claude/statusline-command.sh" "$HOME/.claude/statusline-command.sh"
}

custom_update_claude() {
  run_cmd claude update
}

custom_destroy_claude() {
  run_cmd rm -f "$HOME/.claude/settings.json"
  run_cmd rm -f "$HOME/.claude/statusline-command.sh"
  run_cmd rm -f "$HOME/.local/bin/claude"
  run_cmd rm -rf "$HOME/.local/share/claude"
}
