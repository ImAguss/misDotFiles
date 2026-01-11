#!/bin/bash

GROUP="$1"
STAY="$2"
ACTUAL=$(hyprctl cursorpos | tr -d ',')

if [ -n "$STAY" ]; then
  hyprctl dispatch movecursor "$GROUP"
  wlrctl pointer click left
else
  hyprctl dispatch movecursor "$GROUP"
  wlrctl pointer click left
  hyprctl dispatch movecursor "$ACTUAL"
fi

if [ "$GROUP" = "$ACTUAL" ] && [ -n "$STAY" ]; then
  hyprctl dispatch movecursor "960 540"
fi

