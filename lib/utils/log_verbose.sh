#!/usr/bin/env bash
log_verbose() { 
  [[ "${VERBOSE:-false}" == "true" ]] && echo -e "\033[1;34m$*\033[0m"
}
