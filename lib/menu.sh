#!/usr/bin/env bash

# Requires: gum (https://github.com/charmbracelet/gum), yq
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

for _f in "$ROOT_DIR/lib/utils/"*.sh; do source "$_f"; done
source "$ROOT_DIR/lib/executor.sh"

_sw_emoji() {
  case "$1" in
    docker)             echo "🐳" ;;
    vscode)             echo "💻" ;;
    git)                echo "🔧" ;;
    zsh)                echo "🐚" ;;
    nodejs)             echo "🟩" ;;
    ruby)               echo "💎" ;;
    mise)               echo "⚙️"  ;;
    fonts)              echo "🔤" ;;
    obsidian)           echo "🔮" ;;
    jetbrains_toolbox)  echo "🛠️"  ;;
    gimp)               echo "🎨" ;;
    libreoffice)        echo "📄" ;;
    vlc)                echo "🎬" ;;
    elixir)             echo "💧" ;;
    ssh)                echo "🔑" ;;
    identification)     echo "🪪" ;;
    claude-code)        echo "🤖" ;;
    zellij)             echo "🪟" ;;
    core)               echo "🏗️"  ;;
    *)                  echo "📦" ;;
  esac
}

_manifest_exists() {
  [[ -f "$ROOT_DIR/manifests/$1/$2/$3.yaml" ]] ||
  [[ -f "$ROOT_DIR/manifests/$1/$3.yaml"    ]]
}

_get_description() {
  local path=""
  if   [[ -f "$ROOT_DIR/manifests/$1/$2/install.yaml" ]]; then
    path="$ROOT_DIR/manifests/$1/$2/install.yaml"
  elif [[ -f "$ROOT_DIR/manifests/$1/install.yaml" ]]; then
    path="$ROOT_DIR/manifests/$1/install.yaml"
  fi
  [[ -n "$path" ]] && yq -r '.description // ""' "$path" 2>/dev/null || echo ""
}

_find_software() {
  for _dir in "$ROOT_DIR/manifests"/*/; do
    local _name
    _name=$(basename "$_dir")
    [[ "$_name" == "profiles" ]] && continue
    _manifest_exists "$_name" "$1" "install" && echo "$_name"
  done
}

_ensure_gum() {
  command -v gum &>/dev/null && return 0
  echo "📦 'gum' is required for the interactive menu — installing..."
  if   command -v pacman &>/dev/null; then sudo pacman -S --noconfirm gum
  elif command -v brew   &>/dev/null; then brew install gum
  elif command -v apt-get &>/dev/null; then
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
    echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" \
      | sudo tee /etc/apt/sources.list.d/charm.list > /dev/null
    sudo apt-get update && sudo apt-get install -y gum
  else
    echo "❌ Could not auto-install gum."
    echo "   Install it manually: https://github.com/charmbracelet/gum"
    exit 1
  fi
}

_action_menu() {
  local sw="$1" os="$2"
  local -a opts=()
  _manifest_exists "$sw" "$os" "install" && opts+=("📦  Install")
  _manifest_exists "$sw" "$os" "update"  && opts+=("🔄  Update")
  _manifest_exists "$sw" "$os" "destroy" && opts+=("🗑️   Destroy")
  opts+=("↩️   Back")

  local choice
  choice=$(
    gum choose \
      --header "  $(_sw_emoji "$sw")  $sw — choose action:" \
      --header.foreground=212 \
      "${opts[@]}"
  ) || { echo "back"; return 0; }

  if   [[ "$choice" == *"Install"* ]]; then echo "install"
  elif [[ "$choice" == *"Update"*  ]]; then echo "update"
  elif [[ "$choice" == *"Destroy"* ]]; then echo "destroy"
  else                                       echo "back"
  fi
}

show_menu() {
  detect_os
  local os="$DETECTED_OS"

  if [[ "$os" == "unknown" ]]; then
    echo "❌ Unsupported OS. Only 'arch', 'macos' and 'ubuntu' are supported."
    exit 1
  fi

  _ensure_gum

  while true; do
    local -a items=() sw_names=()
    while IFS= read -r sw; do
      local emoji desc
      emoji=$(_sw_emoji "$sw")
      desc=$(_get_description "$sw" "$os")
      if [[ -n "$desc" ]]; then
        items+=("$emoji  $sw — $desc")
      else
        items+=("$emoji  $sw")
      fi
      sw_names+=("$sw")
    done < <(_find_software "$os")

    items+=("🚪  Exit")

    local total=$(( ${#items[@]} ))
    local choice
    choice=$(
      gum choose \
        --cursor "▶  " \
        --cursor.foreground=212 \
        --header "  🗂️  Dotfiles Manager  ◆  OS: $os  ·  $total items" \
        --header.foreground=212 \
        --header.bold \
        "${items[@]}"
    ) || { echo; gum style --foreground=212 "  👋 Goodbye!"; echo; exit 0; }

    if [[ "$choice" == *"Exit"* ]]; then
      echo
      gum style --foreground=212 "  👋 Goodbye!"
      echo
      exit 0
    fi

    local selected=""
    for i in "${!items[@]}"; do
      if [[ "${items[$i]}" == "$choice" && $i -lt ${#sw_names[@]} ]]; then
        selected="${sw_names[$i]}"
        break
      fi
    done
    [[ -z "$selected" ]] && continue

    while true; do
      local action
      action=$(_action_menu "$selected" "$os")
      [[ "$action" == "back" ]] && break

      echo
      gum style \
        --border rounded \
        --border-foreground 212 \
        --padding "0 2" \
        --bold \
        "$(_sw_emoji "$selected")  Running $action for $selected on $os..."
      echo

      set +e
      run_manifest "$selected" "$os" "$action"
      local rc=$?
      set -e

      echo
      if [[ $rc -eq 0 ]]; then
        gum style --bold --foreground=2 \
          "  ✅  $selected $action completed successfully!"
      else
        gum style --bold --foreground=1 \
          "  ❌  $selected $action failed (exit code: $rc)."
      fi
      echo

      read -rp "  ↩️   Press Enter to return to main menu..." || true
      break
    done
  done
}

show_menu
