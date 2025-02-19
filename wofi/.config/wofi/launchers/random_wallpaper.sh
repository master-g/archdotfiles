#!/bin/bash

directory=~/.config/backgrounds
monitors=($(hyprctl monitors | awk '/Monitor/ {print $2}'))

if [ -d "$directory" ]; then
    random_background=$(ls $directory/*.png | shuf -n 1)

    hyprctl hyprpaper unload all
    hyprctl hyprpaper preload $random_background

    for monitor in "${monitors[@]}"; do
      hyprctl hyprpaper wallpaper "$monitor,$random_background"
    done

fi

sleep 1
