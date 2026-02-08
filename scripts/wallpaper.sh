#!/bin/bash
WALLPAPER_DIR="$HOME/Images/wallpaper/walls"

menu() {
    find "${WALLPAPER_DIR}" -type f \( -iname "*.jpg" \) | awk '{print "img:"$0}'
}

main() {
    choice=$(menu | wofi -c ~/.config/wofi/wallpaper -s ~/.config/wofi/style-wallpaper.css --show dmenu --prompt "Select Wallpaper:" -n)
    selected_wallpaper=$(echo "$choice" | sed 's/^img://')

    wal --cols16 darken --saturate 0.2 --contrast 4.5 -i "$selected_wallpaper"

    if [ $? -ne 0 ]; then
      echo "[INFO] Trying with colorz"
      wal --backend colorz --cols16 darken --saturate 0.2 --contrast 10 -i "$selected_wallpaper"
    fi

    if [ $? -ne 0 ]; then
      echo "[INFO] Trying with fast_colorthief"
      wal --backend fast_colorthief --cols16 darken --saturate 0.2 --contrast 10 -i "$selected_wallpaper"
    fi

    swaync-client --reload-css

    cat ~/.cache/wal/colors-kitty.conf > ~/.config/kitty/current-theme.conf

    color1=$(awk 'match($0, /color2=\47(.*)\47/,a) { print a[1] }' ~/.cache/wal/colors.sh)
    color2=$(awk 'match($0, /color3=\47(.*)\47/,a) { print a[1] }' ~/.cache/wal/colors.sh)
    cava_config="$HOME/.config/cava/config"
    sed -i "s/^gradient_color_1 = .*/gradient_color_1 = '$color1'/" $cava_config
    sed -i "s/^gradient_color_2 = .*/gradient_color_2 = '$color2'/" $cava_config

	  cp $selected_wallpaper ~/Images/wallpaper/pywallpaper.jpg
    source ~/.cache/wal/colors.sh
}

main

