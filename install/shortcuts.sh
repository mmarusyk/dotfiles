#!/bin/bash

set -e

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  #
  # Emoji Picker
  #
  SHORTCUT_NAME="Emoji Picker"
  COMMAND="gnome-characters"
  KEYBINDING="<Control>period"  # Ctrl + .

  # Define the path for the new shortcut
  NEW_BINDING_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/emoji-picker/"

  # Format it for gsettings
  NEW_BINDING_FORMAT="'$NEW_BINDING_PATH'"

  # Get the current list of custom keybindings
  CURRENT_LIST=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)

  # If empty, initialize it
  if [[ "$CURRENT_LIST" == "@as []" ]]; then
    NEW_LIST="[$NEW_BINDING_FORMAT]"
  else
    # Check if our shortcut is already added
    if [[ "$CURRENT_LIST" == *"$NEW_BINDING_PATH"* ]]; then
      NEW_LIST="$CURRENT_LIST"
    else
      # Append to the list
      CURRENT_LIST="${CURRENT_LIST%]*}, $NEW_BINDING_FORMAT]"
      NEW_LIST="$CURRENT_LIST"
    fi
  fi

  # Apply the new custom keybindings list
  gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$NEW_LIST"

  # Set up the actual shortcut values
  gsettings set "org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$NEW_BINDING_PATH" name "$SHORTCUT_NAME"
  gsettings set "org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$NEW_BINDING_PATH" command "$COMMAND"
  gsettings set "org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$NEW_BINDING_PATH" binding "$KEYBINDING"

fi
