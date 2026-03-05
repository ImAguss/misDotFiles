#!/bin/bash

WALLPAPER_DIR="/home/imaguss/.config/hypr/wallpapers/"
WALLPAPER=$(find $WALLPAPER_DIR -type f -name "*.png" | shuf -n 1)

hyprctl hyprpaper wallpaper  ,$WALLPAPER, cover
