#!/usr/bin/env bash
log_verbose() {
  if [[ "${VERBOSE:-false}" == "true" ]]; then
    echo -e "\033[1;34m$*\033[0m"
  fi
  return 0
}
