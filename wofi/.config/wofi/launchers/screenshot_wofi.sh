#!/usr/bin/env bash

# Options
CHOICE=$(echo -e "Manual Area Selection\nWindow Selection\nAll Desktop" | wofi \
  --dmenu \
  --insensitive \
  --prompt "$PROMPT_SCREENSHOT" \
  --width 400 \
  --height 240)

case "$CHOICE" in
  "Manual Area Selection")
      grim -g "$(slurp)" ~/Pictures/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png
      ;;
  "Window Selection")
      # gen window list
      WINDOWS=$(hyprctl clients -j | jq -r '.[] | "\(.address) \(.class) - \(.title)"')

      # wofi selection menu
      # SELECTED=$( echo "$WINDOWS" cliphist list | wofi \
      SELECTED=$( echo "$WINDOWS" | wofi \
        --dmenu \
        --insensitive \
        --prompt "Select Window" \
        --width 800 \
        --height 400 )
#        | cliphist decode | wl-copy --type image

      # handle window selection
      WIN=$(echo "$SELECTED" | awk '{print $1}')

      if [ -n "$WIN" ]; then
          sleep 0.7
          GEOMETRY=$(hyprctl clients -j | jq -r ".[] | select(.address==\"$WIN\") | \"\\(.at[0]),\\(.at[1]) \\(.size[0])x\\(.size[1])\"")
          notify-send "Debug" "$GEOMETRY"
          grim -g "$GEOMETRY" ~/Pictures/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png
      else
          notify-send "Error" "Failed window selection"
      fi
      ;;

  "All Desktop")
      sleep 0.7
      grim ~/Pictures/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png
      ;;
  *)
      notify-send "Error" "Operation cancelled"
      ;;
esac
