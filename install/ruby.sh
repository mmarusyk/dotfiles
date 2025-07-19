#!/bin/bash

set -e

if ! command -v mise &> /dev/null; then
    echo -e "${RED}Mise is not installed! Please install mise first.${NC}"
    exit 1
fi

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  sudo apt update -y
  sudo apt install -yq curl \
    git-core \
    zlib1g-dev \
    build-essential \
    libssl-dev \
    libreadline-dev \
    libyaml-dev \
    libsqlite3-dev \
    sqlite3 \
    libxml2-dev \
    libxslt1-dev \
    libcurl4-openssl-dev \
    software-properties-common \
    libffi-dev \
    libpq-dev
else
  echo -e "${RED}Unsupported OS: $OSTYPE${NC}"
  exit 1
fi

echo -e "${GREEN}\nInstalling the latest Ruby version via Mise...${NC}"
mise use -g ruby
