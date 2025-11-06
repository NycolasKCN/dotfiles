#!/bin/bash

# --- CONFIGURAÇÃO ---
WALLPAPER_B="$HOME/Images/wallpaper/wall1.jpg"
WALLPAPER_A="$HOME/Images/wallpaper/wall2.jpg"
# --------------------

STATE_FILE="/tmp/.wallpaper_toggle_state"

hyprctl hyprpaper preload "$WALLPAPER_A"
hyprctl hyprpaper preload "$WALLPAPER_B"

CURRENT_STATE=$(cat "$STATE_FILE" 2>/dev/null)

if [ "$CURRENT_STATE" == "A" ]; then
  # Muda para B
  hyprctl hyprpaper wallpaper ",$WALLPAPER_B"
  echo "B" > "$STATE_FILE"
	hyprctl hyprpaper unload ",$WALLPAPER_A"
  
  # --- NOTIFICAÇÃO ---
  # -t 2000 define o tempo em milissegundos (2 segundos)
  notify-send -t 2000 "Toggle Wallpaper" "Work mode"

else
  # Muda para A
  hyprctl hyprpaper wallpaper ",$WALLPAPER_A"
  echo "A" > "$STATE_FILE"
	hyprctl hyprpaper unload ",$WALLPAPER_B"
  
  # --- NOTIFICAÇÃO ---
  notify-send -t 2000 "Toggle Wallpaper" "Idle mode"
fi
