#!/usr/bin/env bash
set -euo pipefail

run_manifest() {
  local software=$1   # e.g., kitty, zsh, vscode
  local os=$2         # e.g., arch, ubuntu, macos
  local mode=$3       # e.g., install, update, configure
  local dry_run=${4:-false}    # optional: dry run mode
  local verbose=${5:-false}    # optional: verbose output
  local ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

  local paths=(
    "$ROOT_DIR/manifests/$software/$os/$mode.yaml"
    "$ROOT_DIR/manifests/$software/$mode.yaml"
    "$ROOT_DIR/manifests/$mode.yaml"
  )

  local manifest_path=""
  for path in "${paths[@]}"; do
    [[ "$verbose" == "true" ]] && log_info "🔍 Checking for manifest at: ${path}"
    if [[ -f "$path" ]]; then
      manifest_path="$path"
      break
    fi
  done

  if [[ -z "$manifest_path" ]]; then
    log_error "❌ Manifest not found for '$software' ($os / $mode)"
    return 1
  fi

  log_info "📄 Using manifest: ${manifest_path/$ROOT_DIR\//}"

  # Dependencies
  local deps
  deps=$(yq -r '.depends_on[]?' "$manifest_path" 2>/dev/null || true)
  for dep in $deps; do
    run_manifest "$dep" "$os" "install" "$dry_run" "$verbose"
  done

  # Execute steps
  yq -c '.steps[]' "$manifest_path" | while read -r step; do
    local name cmd
    name=$(echo "$step" | yq -r '.name // "unnamed"')
    cmd=$(echo "$step" | yq -r ".${mode} // empty")
    [[ -z "$cmd" || "$cmd" == "null" ]] && continue
    
    if [[ "$dry_run" == "true" ]]; then
      log_info "🔍 [DRY RUN] [$software] $mode: $name"
      [[ "$verbose" == "true" ]] && echo "Command: $cmd"
    else
      log_info "➡️  [$software] $mode: $name"
      [[ "$verbose" == "true" ]] && echo "Executing: $cmd"
      eval "$cmd"
    fi
  done
}
