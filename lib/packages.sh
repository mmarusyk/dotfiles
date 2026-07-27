#!/usr/bin/env bash
# Package name lookup table — one row per app per OS.
# Empty string means no standard package exists: a custom_install_NAME function
# in lib/apps/ handles it instead.
# Uses flat variables (PKG_<os>__<app>) for bash 3.2 compatibility —
# declare -A (associative arrays) requires bash 4+.

# arch
PKG_arch__git="git"
PKG_arch__zsh="zsh"
PKG_arch__mise="mise"
PKG_arch__tmux="tmux"
PKG_arch__gimp="gimp"
PKG_arch__vlc="vlc"
PKG_arch__libreoffice="libreoffice-fresh"

# ubuntu
PKG_ubuntu__kubernetes=""       # custom install — lib/apps/kubernetes.sh
PKG_ubuntu__azure_cli=""        # custom install — lib/apps/azure-cli.sh
PKG_ubuntu__git="git"
PKG_ubuntu__zsh="zsh"
PKG_ubuntu__mise=""             # curl installer — lib/apps/mise.sh
PKG_ubuntu__tmux="tmux"
PKG_ubuntu__rtk=""              # install script  — lib/apps/rtk.sh
PKG_ubuntu__jetbrains_toolbox="" # custom install — lib/apps/jetbrains-toolbox.sh
PKG_ubuntu__gimp="gimp"
PKG_ubuntu__vlc="vlc"
PKG_ubuntu__libreoffice="libreoffice"
PKG_ubuntu__anki=""             # custom install — lib/apps/anki.sh

# macos
PKG_macos__kubernetes=""        # custom install — lib/apps/kubernetes.sh
PKG_macos__azure_cli="azure-cli"
PKG_macos__git="git"
PKG_macos__dotnet=""            # custom install — lib/apps/dotnet.sh
PKG_macos__zsh="zsh"
PKG_macos__mise="mise"
PKG_macos__tmux="tmux"
PKG_macos__rtk="rtk"
PKG_macos__jetbrains_toolbox="" # custom install — lib/apps/jetbrains-toolbox.sh
PKG_macos__iterm2=""            # custom install — lib/apps/iterm2.sh
PKG_macos__gimp="gimp"
PKG_macos__vlc="vlc"
PKG_macos__libreoffice="libreoffice"
PKG_macos__pr_review_notifier="" # custom install — lib/apps/pr-review-notifier.sh
