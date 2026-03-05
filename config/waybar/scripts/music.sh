#!/bin/bash

# Configuración
MAX_WIDTH=30
SPEED=0.15
MARQUEE_FILE="/tmp/waybar-music-marquee"
CACHE_FILE="/tmp/waybar-music-cache"

# Iconos según el reproductor
get_icon() {
  local player=$(playerctl -l 2>/dev/null | head -n1)
  case "$player" in
  *spotify*) echo "🎵" ;;
  *firefox*) echo "🌐" ;;
  *vlc*) echo "🎬" ;;
  *mpv*) echo "🎥" ;;
  *) echo "🎧" ;;
  esac
}

# Obtener información formateada
get_music_info() {
  local status=$(playerctl status 2>/dev/null)

  # Si no hay reproductor o está detenido
  if [ $? -ne 0 ] || [ "$status" = "Stopped" ]; then
    echo ""
    return
  fi

  local artist=$(playerctl metadata artist 2>/dev/null)
  local title=$(playerctl metadata title 2>/dev/null)
  local icon=$(get_icon)

  if [ -z "$title" ]; then
    echo ""
    return
  fi

  # Formato: [icono] artista - título
  if [ -n "$artist" ]; then
    echo "$icon $artist - $title"
  else
    echo "$icon $title"
  fi
}

# Efecto marquee con separador visual
marquee() {
  local text="$1"
  local status="$2"
  local length=${#text}

  # Si está en pausa, mostrar sin animación pero con indicador
  if [ "$status" = "Paused" ]; then
    local paused_text="${text:0:MAX_WIDTH}"
    echo "{\"text\": \"⏸️ $paused_text\", \"class\": \"paused\"}"
    return
  fi

  # Si el texto cabe, mostrarlo normal
  if [ $length -le $MAX_WIDTH ]; then
    echo "{\"text\": \"$text\", \"class\": \"playing\"}"
    return
  fi

  # Leer offset
  if [ -f "$MARQUEE_FILE" ]; then
    OFFSET=$(cat "$MARQUEE_FILE")
  else
    OFFSET=0
  fi

  # Texto visible con separador " · " cuando se repite
  local visible_text="${text:OFFSET:MAX_WIDTH}"
  local next_part="${text:0:MAX_WIDTH-3}"

  if [ ${#visible_text} -lt $MAX_WIDTH ]; then
    # Estamos al final, mostrar final + principio con separador
    local end_part="${text:OFFSET}"
    local remaining=$((MAX_WIDTH - ${#end_part} - 3))
    if [ $remaining -gt 0 ]; then
      visible_text="${end_part} · ${text:0:remaining}"
    else
      visible_text="${end_part}"
    fi
  fi

  # Actualizar offset
  NEW_OFFSET=$(((OFFSET + 1) % length))
  echo "$NEW_OFFSET" >"$MARQUEE_FILE"

  echo "{\"text\": \"$visible_text\", \"class\": \"playing\"}"
}

# Bucle principal
while true; do
  STATUS=$(playerctl status 2>/dev/null)

  if [ $? -ne 0 ] || [ "$STATUS" = "Stopped" ]; then
    echo "{\"text\": \"\", \"class\": \"stopped\"}"
    rm -f "$MARQUEE_FILE" 2>/dev/null
  else
    TEXT=$(get_music_info)
    marquee "$TEXT" "$STATUS"
  fi

  sleep $SPEED
done
