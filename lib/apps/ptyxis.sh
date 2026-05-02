#!/usr/bin/env bash

custom_install_ptyxis() {
  run_cmd sudo apt-get install -y ptyxis
  config_ptyxis
}

config_ptyxis() {
  local zellij_path
  zellij_path=$(command -v zellij || true)
  if [[ -z "$zellij_path" ]]; then
    log_warn "zellij not found — run 'dots zellij' first"
    return 1
  fi

  local profile_uuid profile_path
  profile_uuid=$(gsettings get org.gnome.Ptyxis default-profile-uuid | tr -d "'")
  profile_path="/org/gnome/Ptyxis/Profiles/${profile_uuid}/"

  run_cmd gsettings set "org.gnome.Ptyxis.Profile:${profile_path}" custom-command "$zellij_path"
  run_cmd gsettings set "org.gnome.Ptyxis.Profile:${profile_path}" use-custom-command true
  run_cmd gsettings set org.gnome.Ptyxis use-system-font false
  run_cmd gsettings set org.gnome.Ptyxis font-name "IosevkaNerdFontMono 12"
}

custom_update_ptyxis() {
  run_cmd sudo apt-get install --only-upgrade -y ptyxis
}

custom_destroy_ptyxis() {
  run_cmd sudo apt-get remove -y ptyxis
}
