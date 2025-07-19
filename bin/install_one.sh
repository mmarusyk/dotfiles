#!/bin/bash

set -e

while true; do
  read -rp "Enter script name(s) separated by space (or type 'back' to return to menu): " input

  if [[ "$input" == "back" ]]; then
    break
  fi

  read -r -a script_names <<< "$input"

  for script_name in "${script_names[@]}"; do
    SCRIPT_PATH="$INSTALL_DIR/install/$script_name"
    if [ -f "$SCRIPT_PATH" ]; then
      echo -e "${BLUE}\nInstalling ${script_name}...${NC}"
      source "$SCRIPT_PATH"
      echo -e "${GREEN}\nInstalling completed.${NC}"
    else
      echo -e "${RED}Script not found: $script_name${NC}"
    fi
  done
done
