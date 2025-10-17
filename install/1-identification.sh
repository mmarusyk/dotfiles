#!/bin/bash

echo -e "\nEnter identification for configuration..."

read -rp "Enter your full name: " DOTFILES_USER_NAME
export DOTFILES_USER_NAME

read -rp "Enter your email: " DOTFILES_USER_EMAIL
export DOTFILES_USER_EMAIL

echo -e "\nYour identification:"
echo "   Name : $DOTFILES_USER_NAME"
echo "   Email: $DOTFILES_USER_EMAIL"

echo -e "\nSaving identification to ~/.dotfiles.env..."
cat > ~/.dotfiles.env << EOF
export DOTFILES_USER_NAME="$DOTFILES_USER_NAME"
export DOTFILES_USER_EMAIL="$DOTFILES_USER_EMAIL"
EOF

echo "Identification saved successfully!"

sleep 3
