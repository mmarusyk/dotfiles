#!/bin/bash

set -e

while true; do
  echo -e "\n${YELLOW}Please choose an option:${NC}"
  echo "  1) Install all scripts"
  echo "  2) Install specific script"
  echo "  3) List scripts"
  echo "  4) Exit"

  read -rp "Enter your choice [1-4]: " choice

  case "$choice" in
    1)
      source "$INSTALL_DIR/bin/install_all.sh"
      ;;

    2)
      source "$INSTALL_DIR/bin/install_one.sh"
      ;;

    3)
      source "$INSTALL_DIR/bin/install_list.sh"
      ;;

    4)
      echo -e "\n${BLUE}Exiting dotfiles installer. Bye!${NC}"
      exit 0
      ;;

    *)
      echo -e "${RED}Invalid choice.${NC}"
      ;;
  esac
done
