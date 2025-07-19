#!/bin/bash

echo -e "\nEnter identification for configuration..."

read -rp "Enter your full name: " DOTFILES_USER_NAME
export DOTFILES_USER_NAME

read -rp "Enter your email: " DOTFILES_USER_EMAIL
export DOTFILES_USER_EMAIL

echo -e "\nYour identification:"
echo "   Name : $DOTFILES_USER_NAME"
echo "   Email: $DOTFILES_USER_EMAIL"

sleep 3
