#!/bin/bash

# --- CONFIGURAÇÃO ---
WALLPAPER_A="$HOME/Imagens/wallpaper/wall1.jpg"
WALLPAPER_B="$HOME/Imagens/wallpaper/wall2.jpg"
# --------------------

STATE_FILE="/tmp/.wallpaper_toggle_state"

hyprctl hyprpaper preload "$WALLPAPER_A"
hyprctl hyprpaper preload "$WALLPAPER_B"

CURRENT_STATE=$(cat "$STATE_FILE" 2>/dev/null)

if [ "$CURRENT_STATE" == "B" ]; then
  # Muda para A
  hyprctl hyprpaper wallpaper ",$WALLPAPER_A, fill"
  echo "A" > "$STATE_FILE"
	hyprctl hyprpaper unload ",$WALLPAPER_B"
  
  # --- NOTIFICAÇÃO ---
  notify-send -t 2000 "Toggle Wallpaper" "Idle mode"
else
  # Muda para B
  hyprctl hyprpaper wallpaper ",$WALLPAPER_B"
  echo "B" > "$STATE_FILE"
	hyprctl hyprpaper unload ",$WALLPAPER_A"
  
  # --- NOTIFICAÇÃO ---
  # -t 2000 define o tempo em milissegundos (2 segundos)
  notify-send -t 2000 "Toggle Wallpaper" "Work mode"
fi
