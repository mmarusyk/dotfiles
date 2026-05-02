#!/usr/bin/env bash

custom_install_identification() {
  echo ""
  log_info "Enter identification for git and SSH configuration..."

  read -rp "Full name:  " DOTFILES_USER_NAME
  read -rp "Email:      " DOTFILES_USER_EMAIL

  export DOTFILES_USER_NAME DOTFILES_USER_EMAIL

  if [[ "${DRY_RUN:-false}" == "true" ]]; then
    echo "[DRY RUN] Would save name/email to $ROOT_DIR/.env"
    return 0
  fi

  cat > "$ROOT_DIR/.env" <<EOF
export DOTFILES_USER_NAME="$DOTFILES_USER_NAME"
export DOTFILES_USER_EMAIL="$DOTFILES_USER_EMAIL"
EOF
  log_success "Identification saved."
}
