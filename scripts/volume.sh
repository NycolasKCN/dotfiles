#!/usr/bin/env bash

NOTIFY_OPTION="$2"

# Get Volume
get_volume() {
    pamixer --get-volume
}

# Notify Volume
notify_user() {
    if [[ "$NOTIFY_OPTION" == "--notify" ]]; then
        if [ "$(pamixer --get-mute)" == "true" ]; then
            notify-send -h string:x-canonical-private-synchronous:sys-notify -u low "  Volume Switched OFF"
        else
            notify-send -h string:x-canonical-private-synchronous:sys-notify -u low "  Volume $(get_volume) %"
        fi
    fi
}

# Increase Volume
inc_volume() {
    pamixer --allow-boost -i 2 && notify_user
}

# Decrease Volume
dec_volume() {
    pamixer --allow-boost -d 2 && notify_user
}

mute_volume() {
    pamixer -m 
}

toggle_mute() {
    if [ "$(pamixer --get-mute)" == "false" ]; then
        mute_volume
    else
        pamixer -u 
    fi
}

toggle_mic() {
    if [ "$(pamixer --default-source --get-mute)" == "false" ]; then
        pamixer --default-source -m 
    else
        pamixer --default-source -u
    fi
}

# Notify Mic
notify_mic_user() {
    if [[ "$NOTIFY_OPTION" == "--notify" ]]; then

        if [ "$(pamixer --default-source --get-mute)" == "true" ]; then
            notify-send -h string:x-canonical-private-synchronous:sys-notify -u low " Mic Muted"
        else
            notify-send -h string:x-canonical-private-synchronous:sys-notify -u low " Mic Level : $(pamixer --default-source --get-volume) %"
        fi
    fi
}

inc_mic_volume() {
    pamixer --default-source --set-limit 150 -i 5 --allow-boost && notify_mic_user
}

dec_mic_volume() {
    pamixer --default-source --allow-boost -d 5 && notify_mic_user
}

# Execute accordingly
case "$1" in
    --get)           get_volume ;;
    --inc)           inc_volume ;;
    --dec)           dec_volume ;;
    --mute)          mute_volume ;;
    --toggle)        toggle_mute ;;
    --toggle-mic)    toggle_mic ;;
    --inc-mic)       inc_mic_volume ;;
    --dec-mic)       dec_mic_volume ;;
    *)               get_volume ;;
esac
