#!/bin/bash

if ! command -v jq &> /dev/null; then
    echo "Erro: 'jq' não foi encontrado. Instale-o para rodar este script."
    exit 1
fi

monitor_data=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true)')

width=$(echo "$monitor_data" | jq -r '.width')
height=$(echo "$monitor_data" | jq -r '.height')
offset_x=$(echo "$monitor_data" | jq -r '.x')
offset_y=$(echo "$monitor_data" | jq -r '.y')

center_x=$(( offset_x + width / 2 ))
center_y=$(( offset_y + height / 2 ))

hyprctl dispatch movecursor "$center_x" "$center_y"
