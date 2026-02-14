#!/usr/bin/env bash
set -euo pipefail

update_apt() {
  local dry_run=${1:-false}
  if ! command -v apt >/dev/null 2>&1; then
    log_verbose "apt not found; skipping apt updates"
    return 0
  fi
  if [[ "$dry_run" == "true" ]]; then
    log_info "[DRY RUN] apt update && apt upgrade -y && apt autoremove -y"
    return 0
  fi
  log_info "Updating apt packages..."
  sudo apt update && sudo DEBIAN_FRONTEND=noninteractive apt -y upgrade && sudo apt -y autoremove
  log_success "apt updates complete"
}

update_pacman() {
  local dry_run=${1:-false}
  if ! command -v pacman >/dev/null 2>&1; then
    log_verbose "pacman not found; skipping pacman updates"
    return 0
  fi
  if [[ "$dry_run" == "true" ]]; then
    log_info "[DRY RUN] pacman -Syu --noconfirm"
    return 0
  fi
  log_info "Updating pacman packages..."
  sudo pacman -Syu --noconfirm
  log_success "pacman updates complete"
}

update_snap() {
  local dry_run=${1:-false}
  if ! command -v snap >/dev/null 2>&1; then
    log_verbose "snap not found; skipping snap updates"
    return 0
  fi
  if [[ "$dry_run" == "true" ]]; then
    log_info "[DRY RUN] snap refresh"
    return 0
  fi
  log_info "Refreshing snaps..."
  sudo snap refresh
  log_success "snap refresh complete"
}

update_flatpak() {
  local dry_run=${1:-false}
  if ! command -v flatpak >/dev/null 2>&1; then
    log_verbose "flatpak not found; skipping flatpak updates"
    return 0
  fi
  if [[ "$dry_run" == "true" ]]; then
    log_info "[DRY RUN] flatpak update -y"
    return 0
  fi
  log_info "Updating flatpak apps..."
  flatpak update -y
  log_success "flatpak updates complete"
}

update_brew() {
  local dry_run=${1:-false}
  if ! command -v brew >/dev/null 2>&1; then
    log_verbose "brew not found; skipping brew updates"
    return 0
  fi
  if [[ "$dry_run" == "true" ]]; then
    log_info "[DRY RUN] brew update && brew upgrade && brew cleanup"
    return 0
  fi
  log_info "Updating Homebrew..."
  brew update && brew upgrade && brew cleanup
  log_success "brew updates complete"
}

update_npm_global() {
  local dry_run=${1:-false}
  if ! command -v npm >/dev/null 2>&1; then
    log_verbose "npm not found; skipping npm global updates"
    return 0
  fi
  if [[ "$dry_run" == "true" ]]; then
    log_info "[DRY RUN] npm -g update"
    return 0
  fi
  log_info "Updating global npm packages..."
  npm -g update
  log_success "npm global updates complete"
}

update_pip() {
  local dry_run=${1:-false}
  if ! command -v python3 >/dev/null 2>&1 || ! python3 -m pip --version >/dev/null 2>&1; then
    log_verbose "pip not found; skipping pip updates"
    return 0
  fi
  if [[ "$dry_run" == "true" ]]; then
    log_info "[DRY RUN] python3 -m pip install --upgrade pip; list outdated packages"
    return 0
  fi
    log_info "Upgrading pip and checking outdated packages..."
    # Try upgrading pip but handle PEP 668 / externally-managed-environment gracefully
    local pip_upgrade_out
    pip_upgrade_out=$(python3 -m pip install --upgrade --user pip 2>&1) || true
    if echo "$pip_upgrade_out" | grep -qi "externally-managed-environment"; then
      log_error "pip upgrade skipped: externally-managed environment detected (PEP 668)."
      log_info "Use a virtual environment or 'pipx' for non-distro packages; skipping pip upgrade."
    else
      # Only show success when pip upgrade didn't report PEP668
      [[ -n "$pip_upgrade_out" ]] && log_info "$pip_upgrade_out"
    fi

    local pkgs
    pkgs=$(python3 -m pip list --outdated --format=freeze 2>/dev/null || true)
    if [[ -z "$pkgs" ]]; then
      log_info "No outdated pip packages found"
    else
      log_info "Upgrading outdated pip packages (user installs)..."
      # Attempt to upgrade each package to the latest in user context; handle failures
      echo "$pkgs" | cut -d'=' -f1 | while read -r pkg; do
        [[ -z "$pkg" ]] && continue
        log_info "Upgrading pip package: $pkg"
        out=$(python3 -m pip install --upgrade --user "$pkg" 2>&1) || true
        if echo "$out" | grep -qi "externally-managed-environment"; then
          log_error "Cannot upgrade '$pkg' here: externally-managed environment detected. Skipping."
          log_info "Recommendation: install via your distro package manager, use a venv, or use 'pipx' for CLI apps."
        else
          log_info "$out"
        fi
      done
    fi
    log_success "pip updates complete"
}

update_cargo() {
  local dry_run=${1:-false}
  if ! command -v cargo >/dev/null 2>&1; then
    log_verbose "cargo not found; skipping cargo updates"
    return 0
  fi
  if [[ "$dry_run" == "true" ]]; then
    log_info "[DRY RUN] cargo install-update -a (or cargo install --list)"
    return 0
  fi
  log_info "Updating cargo-installed tools (best effort)..."
  if command -v cargo-install-update >/dev/null 2>&1; then
    cargo install-update -a || true
  else
    log_info "cargo-install-update not found; skipping automated cargo updates"
  fi
  log_success "cargo updates attempted"
}

update_yay() {
  local dry_run=${1:-false}
  if ! command -v yay >/dev/null 2>&1; then
    log_verbose "yay not found; skipping yay updates"
    return 0
  fi
  if [[ "$dry_run" == "true" ]]; then
    log_info "[DRY RUN] yay -Syu --noconfirm"
    return 0
  fi
  log_info "Updating AUR packages with yay..."
  yay -Syu --noconfirm || true
  log_success "yay updates attempted"
}

update_paru() {
  local dry_run=${1:-false}
  if ! command -v paru >/dev/null 2>&1; then
    log_verbose "paru not found; skipping paru updates"
    return 0
  fi
  if [[ "$dry_run" == "true" ]]; then
    log_info "[DRY RUN] paru -Syu --noconfirm"
    return 0
  fi
  log_info "Updating AUR packages with paru..."
  paru -Syu --noconfirm || true
  log_success "paru updates attempted"
}

update_dnf() {
  local dry_run=${1:-false}
  if ! command -v dnf >/dev/null 2>&1; then
    log_verbose "dnf not found; skipping dnf updates"
    return 0
  fi
  if [[ "$dry_run" == "true" ]]; then
    log_info "[DRY RUN] sudo dnf -y upgrade"
    return 0
  fi
  log_info "Updating dnf packages..."
  sudo dnf -y upgrade || true
  log_success "dnf updates attempted"
}

update_zypper() {
  local dry_run=${1:-false}
  if ! command -v zypper >/dev/null 2>&1; then
    log_verbose "zypper not found; skipping zypper updates"
    return 0
  fi
  if [[ "$dry_run" == "true" ]]; then
    log_info "[DRY RUN] sudo zypper refresh && sudo zypper dup -y"
    return 0
  fi
  log_info "Updating zypper packages..."
  sudo zypper refresh && sudo zypper dup -y || true
  log_success "zypper updates attempted"
}

update_apk() {
  local dry_run=${1:-false}
  if ! command -v apk >/dev/null 2>&1; then
    log_verbose "apk not found; skipping apk updates"
    return 0
  fi
  if [[ "$dry_run" == "true" ]]; then
    log_info "[DRY RUN] sudo apk update && sudo apk upgrade"
    return 0
  fi
  log_info "Updating apk packages..."
  sudo apk update && sudo apk upgrade || true
  log_success "apk updates attempted"
}

update_xbps() {
  local dry_run=${1:-false}
  if ! command -v xbps-install >/dev/null 2>&1; then
    log_verbose "xbps not found; skipping xbps updates"
    return 0
  fi
  if [[ "$dry_run" == "true" ]]; then
    log_info "[DRY RUN] sudo xbps-install -Su"
    return 0
  fi
  log_info "Updating xbps packages..."
  sudo xbps-install -Su || true
  log_success "xbps updates attempted"
}

update_mas() {
  local dry_run=${1:-false}
  if ! command -v mas >/dev/null 2>&1; then
    log_verbose "mas not found; skipping mas updates"
    return 0
  fi
  if [[ "$dry_run" == "true" ]]; then
    log_info "[DRY RUN] mas upgrade"
    return 0
  fi
  log_info "Updating App Store apps via mas..."
  mas upgrade || true
  log_success "mas updates attempted"
}

update_nix() {
  local dry_run=${1:-false}
  if ! command -v nix-env >/dev/null 2>&1; then
    log_verbose "nix not found; skipping nix updates"
    return 0
  fi
  if [[ "$dry_run" == "true" ]]; then
    log_info "[DRY RUN] nix-env -u '*'"
    return 0
  fi
  log_info "Updating Nix packages..."
  nix-env -u '*' || true
  log_success "nix updates attempted"
}

update_pipx() {
  local dry_run=${1:-false}
  if ! command -v pipx >/dev/null 2>&1; then
    log_verbose "pipx not found; skipping pipx updates"
    return 0
  fi
  if [[ "$dry_run" == "true" ]]; then
    log_info "[DRY RUN] pipx upgrade-all"
    return 0
  fi
  log_info "Upgrading pipx-managed packages..."
  if pipx --version >/dev/null 2>&1; then
    # pipx provides an 'upgrade-all' command
    if pipx upgrade-all >/dev/null 2>&1; then
      log_success "pipx packages upgraded"
    else
      # Some pipx versions may not print to stdout nicely; run again capturing output
      out=$(pipx upgrade-all 2>&1) || true
      log_info "$out"
      log_success "pipx upgrade attempted"
    fi
  else
    log_error "pipx present but failed to run; skipping"
  fi
}

update_all_user_tools() {
  local dry_run=${1:-false}
  update_npm_global "$dry_run"
  update_pip "$dry_run"
  update_cargo "$dry_run"
}

default_managers_for_os() {
  case "${DETECTED_OS:-unknown}" in
    ubuntu)
      echo "apt snap flatpak" ;;
    arch)
      echo "pacman" ;;
    macos)
      echo "brew" ;;
    *)
      echo "apt pacman brew" ;;
  esac
}
