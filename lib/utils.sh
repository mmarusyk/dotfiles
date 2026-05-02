#!/usr/bin/env bash

# ── Logging ────────────────────────────────────────────────────────────────────
log_info()    { echo -e "\033[1;34m$*\033[0m"; }
log_success() { echo -e "\033[1;32m$*\033[0m"; }
log_warn()    { echo -e "\033[1;33m$*\033[0m"; }
log_error()   { echo -e "\033[1;31m$*\033[0m" >&2; }
log_verbose() { [[ "${VERBOSE:-false}" == "true" ]] && echo -e "\033[1;34m$*\033[0m" || true; }

# ── OS detection ───────────────────────────────────────────────────────────────
detect_os() {
  if [[ "${OSTYPE:-}" == "darwin"* ]]; then
    DETECTED_OS="macos"
  elif [[ -f /etc/arch-release ]]; then
    DETECTED_OS="arch"
  elif grep -qi "ubuntu" /etc/os-release 2>/dev/null; then
    DETECTED_OS="ubuntu"
  else
    DETECTED_OS="unknown"
  fi
  export DETECTED_OS
}

# ── Command runner ─────────────────────────────────────────────────────────────
# Wraps every side-effecting call for dry-run and verbose support.
# Use run_cmd for simple commands. For pipes, guard with [[ "$DRY_RUN" != "true" ]].
run_cmd() {
  if [[ "${VERBOSE:-false}" == "true" ]]; then log_verbose "+ $*"; fi
  if [[ "${DRY_RUN:-false}" == "true" ]]; then echo "[DRY RUN] $*"; return 0; fi
  "$@"
}

# ── Package management ─────────────────────────────────────────────────────────
_resolve_pkg() {
  local app=$1
  local pkg_var="PKG_${DETECTED_OS}[${app}]"
  echo "${!pkg_var:-}"
}

pkg_install() {
  local app=$1
  local pkg
  pkg=$(_resolve_pkg "$app")
  if [[ -z "$pkg" ]]; then
    log_error "No package defined for '${app}' on ${DETECTED_OS}"
    return 1
  fi
  case $DETECTED_OS in
    arch)   run_cmd sudo pacman -S --noconfirm "$pkg" ;;
    ubuntu) run_cmd sudo apt-get install -y "$pkg" ;;
    macos)  run_cmd brew install "$pkg" ;;
  esac
}

pkg_update() {
  local app=$1
  local pkg
  pkg=$(_resolve_pkg "$app")
  if [[ -z "$pkg" ]]; then
    log_warn "No package entry for '${app}' on ${DETECTED_OS} — skipping update"
    return 0
  fi
  case $DETECTED_OS in
    arch)   run_cmd sudo pacman -S --noconfirm "$pkg" ;;
    ubuntu) run_cmd sudo apt-get install --only-upgrade -y "$pkg" ;;
    macos)  run_cmd brew upgrade "$pkg" ;;
  esac
}

pkg_destroy() {
  local app=$1
  local pkg
  pkg=$(_resolve_pkg "$app")
  if [[ -z "$pkg" ]]; then
    log_warn "No package entry for '${app}' on ${DETECTED_OS} — skipping destroy"
    return 0
  fi
  case $DETECTED_OS in
    arch)   run_cmd sudo pacman -Rns --noconfirm "$pkg" ;;
    ubuntu) run_cmd sudo apt-get remove -y "$pkg" ;;
    macos)  run_cmd brew uninstall "$pkg" ;;
  esac
}

# ── Dependency check ───────────────────────────────────────────────────────────
require_dependencies() {
  for dep in "$@"; do
    if ! command -v "$dep" &>/dev/null; then
      log_error "Missing dependency: $dep"
      exit 1
    fi
  done
}
