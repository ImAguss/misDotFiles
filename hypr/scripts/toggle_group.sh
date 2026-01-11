#!/bin/bash

GROUP="$1"
ACTUAL=$(hyprctl cursorpos | tr -d ',')

hyprctl dispatch movecursor "$GROUP"
wlrctl pointer click left
hyprctl dispatch movecursor "$ACTUAL"


