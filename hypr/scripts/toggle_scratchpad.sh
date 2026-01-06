#!/bin/bash
# toggle_simple.sh <special-name> <app-class> <size> <move/center> <exec-command> <type>

SPECIAL="special:$1"
APP="$2"
SIZE="size $3"
POS="move $4"  # "move X Y" o "center"
EXEC="$5"
TYPE="$6"

if [ -z "$TYPE" ]; then
    TYPE="float"
fi

if [ "$POS" == "move center" ]; then
  POS="center"
fi

EXISTS=$(hyprctl -j clients | jq --arg ws "$SPECIAL" --arg class "$APP" \
  '[.[] | select(.workspace.name == $ws and .class == $class)] | length')

if [ "$EXISTS" -gt 0 ]; then
    hyprctl dispatch togglespecialworkspace "$1"
else
    if [ -n "$EXEC" ]; then
      hyprctl dispatch exec "[workspace $SPECIAL; $TYPE; $SIZE; $POS] $EXEC"
    else
      hyprctl dispatch exec "[workspace $SPECIAL; $TYPE; $SIZE; $POS] $APP"
    fi
fi
