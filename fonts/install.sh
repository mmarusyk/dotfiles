#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'
DOWNLOAD_URL="https://rubjo.github.io/victor-mono/VictorMonoAll.zip"
DESTINATION_DIR="$HOME/.local/share/fonts/victor-mono"

if [ ! -d "$DESTINATION_DIR" ]; then
  # Create the destination directory if it doesn't exist
  mkdir -p "$DESTINATION_DIR"

  # Download the font zip file using curl
  curl -L "$DOWNLOAD_URL" -o "/tmp/VictorMonoAll.zip"

  # Extract the contents to the destination directory
  unzip -o "/tmp/VictorMonoAll.zip" -d "$DESTINATION_DIR"

  # Update the font cache
  fc-cache -f -v

  # Clean up the temporary zip file
  rm "/tmp/VictorMonoAll.zip"

  printf "$GREEN\nVictor Mono font has been installed.$NC\n"
else
  printf "$YELLOW\nVictor Mono font is already installed.$NC\n"
fi
