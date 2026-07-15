#!/bin/bash
WALLPAPER_DIR="$HOME/Dotfiles/wallpapers"

menu() {
  find "${WALLPAPER_DIR}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | awk '{print "img:"$0}'
}

changeCavaColor() {
  color1=$(awk 'match($0, /color2=\47(.*)\47/,a) { print a[1] }' ~/.cache/wal/colors.sh)
  color2=$(awk 'match($0, /color3=\47(.*)\47/,a) { print a[1] }' ~/.cache/wal/colors.sh)
  cava_config="$HOME/.config/cava/config"
  sed -i "s/^gradient_color_1 = .*/gradient_color_1 = '$color1'/" $cava_config
  sed -i "s/^gradient_color_2 = .*/gradient_color_2 = '$color2'/" $cava_config
}

changeKittyColor() {
  cat ~/.cache/wal/colors-kitty.conf > ~/.config/kitty/current-theme.conf
  kitty @ load-config
}

changeHyprColor() {
  INPUT="${HOME}/.cache/wal/colors-hyprland.conf"
  OUTPUT="${HOME}/.config/hypr/conf/colors.lua"
  local pattern='^\$([a-zA-Z0-9]+)[[:space:]]*=[[:space:]]*(rgba\([^)]+\))'
  {
    echo "return {"

    while IFS= read -r line; do
      [[ -z "$line" || "$line" == \#* || "$line" == \$wallpaper* ]] && continue

      if [[ "$line" =~ $pattern ]]; then
        key="${BASH_REMATCH[1]}"
        value="${BASH_REMATCH[2]}"
        printf '  %s = "%s",\n' "$key" "$value"
      fi
    done < "$INPUT"

    echo "}"
  } > "$OUTPUT"
  hyprctl reload
}

# --- NOVA FUNÇÃO PARA O OMARCHY ---
changeOmarchyColor() {

  OMARCHY_CONF="$HOME/.config/omarchy/current/theme/colors.toml"

  cat <<EOF > "$OMARCHY_CONF"
accent = "$color4"
active_border_color = "$color15"
active_tab_background = "$color4"

# Cursor colors
cursor = "$cursor"

# Primary colors
foreground = "$foreground"
background = "$background"

# Selection colors
selection_foreground = "$background"
selection_background = "$color4"

# Normal colors (ANSI 0-7)
color0  = "$color0"
color1  = "$color1"
color2  = "$color2"
color3  = "$color3"
color4  = "$color4"
color5  = "$color5"
color6  = "$color6"
color7  = "$color7"

# Bright colors (ANSI 8-15)
color8  = "$color8"
color9  = "$color9"
color10 = "$color10"
color11 = "$color11"
color12 = "$color12"
color13 = "$color13"
color14 = "$color14"
color15 = "$color15"
EOF
}

main() {
    choice=$(menu | wofi -c ~/.config/wofi/wallpaper -s ~/.config/wofi/style-wallpaper.css --show dmenu --prompt "Select Wallpaper:" -n)
    selected_wallpaper=$(echo "$choice" | sed 's/^img://')

    wal --cols16 darken --saturate 0.2 --contrast 5 -i "$selected_wallpaper"

    if [ $? -ne 0 ]; then
      echo "[INFO] Trying with colorz"
      wal --backend colorz --cols16 darken --saturate 0.2 --contrast 4 -i "$selected_wallpaper"
    fi

    if [ $? -ne 0 ]; then
      echo "[INFO] Trying with fast_colorthief"
      wal --backend fast_colorthief --cols16 darken --saturate 0.2 --contrast 4 -i "$selected_wallpaper"
    fi

    swaync-client --reload-css
    source ~/.cache/wal/colors.sh

    changeKittyColor
    changeCavaColor
    changeHyprColor
    changeOmarchyColor

    systemctl --user restart waybar-ycal.service
    cp "$selected_wallpaper" ~/Images/wallpaper/pywallpaper.jpg
}

main
