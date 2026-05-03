#!/bin/env bash

# Verifica se já está gravando para parar o processo
if pgrep -x wf-recorder > /dev/null; then
    pkill -INT -x wf-recorder
    notify-send "Stoping recording" "$(cat /tmp/recording.txt)"
    
    # Copia o caminho do arquivo para a área de transferência
    wl-copy < "$(cat /tmp/recording.txt)"
    exit 0
fi

# Menu do Wofi com as novas opções separadas
SELECTION=$(echo -e "screenshot selection\nscreenshot DP-1\nscreenshot DP-2\nscreenshot both screens\nrecord selection (silent)\nrecord selection (audio)\nrecord DP-1 (silent)\nrecord DP-1 (audio)\nrecord DP-2 (silent)\nrecord DP-2 (audio)" | wofi -c ~/.config/wofi/capture --show dmenu -n)

IMG="${HOME}/Images/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"
VID="${HOME}/Videos/Captures/$(date +%Y-%m-%d_%H-%M-%S).mp4"

case "$SELECTION" in
    # --- RECORD SELECTION ---
    "record selection (silent)")
        echo "$VID" > /tmp/recording.txt
        notify-send -u low "Capture" "Starting capturing selection (Silent)"
        # Sem a flag --audio
        wf-recorder -r 60 -g "$(slurp)" -f "$VID" -y 2> /tmp/wf-rec-err.log & disown
        ;;
    "record selection (audio)")
        echo "$VID" > /tmp/recording.txt
        notify-send -u low "Capture" "Starting capturing selection (Audio)"
        # Com a flag --audio
        wf-recorder --audio -r 60 -g "$(slurp)" -f "$VID" -y 2> /tmp/wf-rec-err.log & disown
        ;;

    # --- RECORD DP-1 ---
    "record DP-1 (silent)")
        echo "$VID" > /tmp/recording.txt
        notify-send -u low "Capture" "Starting capturing DP-1 (Silent)"
        wf-recorder -r 60 -o DP-1 -f "$VID" -y 2> /tmp/wf-rec-err.log  & disown
        ;;
    "record DP-1 (audio)")
        echo "$VID" > /tmp/recording.txt
        notify-send -u low "Capture" "Starting capturing DP-1 (Audio)"
        wf-recorder --audio -r 60 -o DP-1 -f "$VID" -y 2> /tmp/wf-rec-err.log  & disown
        ;;

    # --- RECORD DP-2 ---
    "record DP-2 (silent)")
        echo "$VID" > /tmp/recording.txt
        notify-send -u low "Capture" "Starting capturing DP-2 (Silent)"
        wf-recorder -r 60 -o DP-2 -f "$VID" -y 2> /tmp/wf-rec-err.log  & disown
        ;;
    "record DP-2 (audio)")
        echo "$VID" > /tmp/recording.txt
        notify-send -u low "Capture" "Starting capturing DP-2 (Audio)"
        wf-recorder --audio -r 60 -o DP-2 -f "$VID" -y 2> /tmp/wf-rec-err.log  & disown
        ;;
    # --- SCREESHOTS (Mantidos iguais) ---
    "screenshot selection")
        grim -g "$(slurp)" "$IMG"
        wl-copy < "$IMG"
        notify-send -u low "Capture" "Selected region captured\n${IMG}"
        ;;
    "screenshot DP-1")
        grim -c -o DP-1 "$IMG"
        wl-copy < "$IMG"
        notify-send -u low "Capture" "DP-1 screen captured\n${IMG}"
        ;;
    "screenshot DP-2")
        grim -c -o DP-2 "$IMG"
        wl-copy < "$IMG"
        notify-send -u low "Capture" "DP-2 screen captured\n${IMG}"
        ;;
    "screenshot both screens")
        grim -c -o DP-1 "${IMG//.png/-DP-1.png}"
        grim -c -o DP-2 "${IMG//.png/-DP-2.png}"
        montage "${IMG//.png/-DP-1.png}" "${IMG//.png/-DP-2.png}" -tile 2x1 -geometry +0+0 "$IMG" 
        wl-copy < "$IMG"
        rm "${IMG//.png/-DP-1.png}" "${IMG/.png/-DP-2.png}"
        notify-send -u low "Capture" "Both screens captured\n${IMG}"
        ;;
    *)
        ;;
esac
