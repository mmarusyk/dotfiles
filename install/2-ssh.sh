#!/bin/bash

set -e

echo -e "\nSSH Key Setup"

SSH_KEY="$HOME/.ssh/id_ed25519"

if [[ -f "$SSH_KEY" ]]; then
  echo -e "${GREEN}SSH key already exists at: $SSH_KEY${NC}"
else
  echo -e "${YELLOW}No SSH key found at: $SSH_KEY${NC}"
  
  read -rp "Do you want to generate a new SSH key now? (y/n): " CREATE_KEY
  if [[ "$CREATE_KEY" =~ ^[Yy]$ ]]; then
    ssh-keygen -t ed25519 -C "$DOTFILES_USER_EMAIL" -f "$SSH_KEY" -N ""
    echo -e "${GREEN}SSH key generated.${NC}"
  fi
fi
