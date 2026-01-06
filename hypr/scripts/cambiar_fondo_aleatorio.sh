#!/bin/bash

WALLPAPER_DIR="/home/imaguss/.config/hypr/wallpapers/"
WALLPAPER=$(find $WALLPAPER_DIR -type f -name "*.png" | shuf -n 1)

echo "$WALLPAPER"

hyprctl hyprpaper preload $WALLPAPER
hyprctl hyprpaper wallpaper eDP-1,$WALLPAPER
