#!/usr/bin/env bash
require_dependencies() {
  for dep in "$@"; do
    if ! command -v "$dep" >/dev/null 2>&1; then
      echo "❌ Missing dependency: $dep"
      exit 1
    fi
  done
}
