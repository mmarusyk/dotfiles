#!/bin/bash

chosen=$(printf "󰌾  Lock\n󰍃  Logout\n󰜉  Reboot\n⏻  Poweroff" | wofi --dmenu --prompt "Power" --lines 4 --width 200)

case "$chosen" in
    "󰌾  Lock") hyprlock ;;
    "󰍃  Logout") command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit ;;
    "󰜉  Reboot") systemctl reboot ;;
    "⏻  Poweroff") systemctl poweroff ;;
esac
