#!/bin/bash

set -e

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  sudo apt update -y
  sudo apt install -y vlc
fi
