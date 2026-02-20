#!/bin/bash

if  ! sudo systemctl is-active --quiet open-webui ; then
    sudo systemctl start open-webui
fi

hyprctl dispatch exec "[workspace 5 silent] kitty -e ollama serve"
sleep 5
hyprctl dispatch exec "firefox http://localhost:8080"