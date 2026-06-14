#!/usr/bin/env bash
# Package name lookup table — one row per app per OS.
# Empty string means no standard package exists: a custom_install_NAME function
# in lib/apps/ handles it instead.

declare -A PKG_arch=(
  [git]="git"
  [zsh]="zsh"
  [mise]="mise"
  [tmux]="tmux"
  [gimp]="gimp"
  [vlc]="vlc"
  [libreoffice]="libreoffice-fresh"
)

declare -A PKG_ubuntu=(
  [azure-cli]=""     # custom install — lib/apps/azure-cli.sh
  [git]="git"
  [zsh]="zsh"
  [mise]=""         # curl installer — lib/apps/mise.sh
  [tmux]="tmux"
  [rtk]=""          # install script  — lib/apps/rtk.sh
  [jetbrains-toolbox]=""  # custom install — lib/apps/jetbrains-toolbox.sh
  [gimp]="gimp"
  [vlc]="vlc"
  [libreoffice]="libreoffice"
  [anki]=""            # custom install — lib/apps/anki.sh
)

declare -A PKG_macos=(
  [azure-cli]="azure-cli"
  [git]="git"
  [dotnet]=""       # custom install — lib/apps/dotnet.sh
  [zsh]="zsh"
  [mise]="mise"
  [tmux]="tmux"
  [rtk]="rtk"
  [jetbrains-toolbox]=""  # custom install — lib/apps/jetbrains-toolbox.sh
  [iterm2]=""            # custom install — lib/apps/iterm2.sh
  [gimp]="gimp"
  [vlc]="vlc"
  [libreoffice]="libreoffice"
)
