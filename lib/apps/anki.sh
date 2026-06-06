#!/usr/bin/env bash

_anki_latest_url() {
  local page=1
  while [[ $page -le 5 ]]; do
    local url
    url=$(curl -fsSL "https://api.github.com/repos/ankitects/anki/releases?per_page=10&page=${page}" \
      | grep -o '"browser_download_url": "[^"]*anki-launcher[^"]*linux\.tar\.zst"' \
      | head -n1 \
      | grep -o 'https://[^"]*')
    [[ -n "$url" ]] && echo "$url" && return 0
    (( page++ ))
  done
  return 1
}

custom_install_anki() {
  if [[ "$DETECTED_OS" != "ubuntu" ]]; then
    log_warn "Anki custom install is Ubuntu-only; skipping on $DETECTED_OS"
    return 0
  fi

  run_cmd sudo apt-get install -y \
    libxcb-xinerama0 libxcb-cursor0 libnss3 libxcb-icccm4 libxcb-keysyms1 zstd

  local url
  if [[ "${DRY_RUN:-false}" == "true" ]]; then
    echo "[DRY RUN] resolve latest anki-launcher URL from GitHub releases"
    echo "[DRY RUN] curl -Lo /tmp/anki-launcher.tar.zst <url>"
    echo "[DRY RUN] tar xaf /tmp/anki-launcher.tar.zst -C /tmp"
    echo "[DRY RUN] cd /tmp/anki-launcher-* && sudo ./install.sh"
    echo "[DRY RUN] rm -rf /tmp/anki-launcher* /tmp/anki-launcher.tar.zst"
    return 0
  fi

  url=$(_anki_latest_url)
  if [[ -z "$url" ]]; then
    log_error "Could not resolve Anki download URL"
    return 1
  fi

  run_cmd curl -Lo /tmp/anki-launcher.tar.zst "$url"
  run_cmd tar xaf /tmp/anki-launcher.tar.zst -C /tmp
  local dir
  dir=$(find /tmp -maxdepth 1 -type d -name 'anki-launcher-*' | head -n1)
  (cd "$dir" && run_cmd sudo ./install.sh)
  run_cmd rm -rf "$dir" /tmp/anki-launcher.tar.zst
}

custom_update_anki() {
  if [[ "$DETECTED_OS" != "ubuntu" ]]; then
    log_warn "Anki custom update is Ubuntu-only; skipping on $DETECTED_OS"
    return 0
  fi
  custom_install_anki
}

custom_destroy_anki() {
  if [[ "$DETECTED_OS" != "ubuntu" ]]; then
    log_warn "Anki custom destroy is Ubuntu-only; skipping on $DETECTED_OS"
    return 0
  fi
  run_cmd sudo rm -f /usr/local/bin/anki
  run_cmd sudo rm -rf /usr/share/anki
}
