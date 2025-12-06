#!/usr/bin/env bash
detect_os() {
  if [[ "${OSTYPE:-}" == "darwin"* ]]; then
    DETECTED_OS="macos"
  elif [[ -f /etc/arch-release ]]; then
    DETECTED_OS="arch"
  elif [[ -f /etc/debian_version ]]; then
    DETECTED_OS="ubuntu"
  else
    DETECTED_OS="unknown"
  fi
  export DETECTED_OS
}
