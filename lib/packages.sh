#!/usr/bin/env bash
# Package name lookup table — one row per app per OS.
# Empty string means no standard package exists: a custom_install_NAME function
# in lib/apps/ handles it instead.

declare -A PKG_arch=(
  [git]="git"
  [zsh]="zsh"
  [mise]="mise"
  [zellij]="zellij"
  [gimp]="gimp"
  [vlc]="vlc"
  [libreoffice]="libreoffice-fresh"
)

declare -A PKG_ubuntu=(
  [git]="git"
  [zsh]="zsh"
  [mise]=""         # curl installer — lib/apps/mise.sh
  [zellij]=""       # GitHub release  — lib/apps/zellij.sh
  [rtk]=""          # install script  — lib/apps/rtk.sh
  [gimp]="gimp"
  [vlc]="vlc"
  [libreoffice]="libreoffice"
)

declare -A PKG_macos=(
  [git]="git"
  [dotnet]=""       # custom install — lib/apps/dotnet.sh
  [zsh]="zsh"
  [mise]="mise"
  [zellij]="zellij"
  [rtk]="rtk"
  [gimp]="gimp"
  [vlc]="vlc"
  [libreoffice]="libreoffice"
)
