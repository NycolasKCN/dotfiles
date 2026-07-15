#!/bin/bash

# Code from: https://github.com/basecamp/omarchy/issues/2509
#
#
# --- CONFIGURATION ---
STEP=2
STATE_FILE_PREFIX="/tmp/waybar_brightness"
# ---------------------

get_icon() {
	current="$(get_backlight)"
	if [[ ("$current" -ge "0") && ("$current" -le "19200") ]]; then
		icon="$iDIR/brightness-20.png"
	elif [[ ("$current" -ge "19200") && ("$current" -le "38400") ]]; then
		icon="$iDIR/brightness-40.png"
	elif [[ ("$current" -ge "38400") && ("$current" -le "57600") ]]; then
		icon="$iDIR/brightness-60.png"
	elif [[ ("$current" -ge "57600") && ("$current" -le "76800") ]]; then
		icon="$iDIR/brightness-80.png"
	elif [[ ("$current" -ge "76800") && ("$current" -le "96000") ]]; then
		icon="$iDIR/brightness-100.png"
	fi
}

notify() {
  local brightness_value="$1"
  echo "$brightness_value" br > $XDG_RUNTIME_DIR/wob.sock
}

# Get monitor name - either from argument, env var, or focused monitor
get_monitor_name() {
    if [ -n "$1" ]; then
        echo "$1"
    elif [ -n "$WAYBAR_OUTPUT_NAME" ]; then
        echo "$WAYBAR_OUTPUT_NAME"
    else
        hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name'
    fi
}

# Get ddcutil display number for a monitor
get_ddcutil_display_bus() {
    local monitor_name="$1"
    case "$monitor_name" in
        "DP-1")
            echo "2"
            ;;
        # Add more monitors here as needed:
        # "DP-4")
        #     echo "2"
        #     ;;
        "DP-2")
            echo ""
            ;;
        *)
            echo ""  # No DDC/CI support
            ;;
    esac
}

# Get state file for this monitor
get_state_file() {
    local monitor="$1"
    echo "${STATE_FILE_PREFIX}_${monitor}.tmp"
}

# Function to send DDC/CI command in background
set_brightness_ddcutil() {
    local display_num="$1"
    local brightness="$2"
    pkill -f "ddcutil.*setvcp 10"
    (ddcutil --bus "$display_num" setvcp 10 "$brightness") &
}

# Function to set laptop brightness
set_brightness_laptop() {
    local brightness="$1"
    brightnessctl set "${brightness}%" > /dev/null 2>&1
}

# Get current brightness for a specific monitor
get_current_brightness() {
    local monitor="$1"
    local state_file=$(get_state_file "$monitor")
    local display_num=$(get_ddcutil_display_bus "$monitor")
    
    if [ "$monitor" = "eDP-1" ]; then
        # Laptop display
        if [ ! -f "$state_file" ]; then
            local current=$(brightnessctl get 2>/dev/null || echo "0")
            local max=$(brightnessctl max 2>/dev/null || echo "1")
            local percent=$((current * 100 / max))
            echo "$percent" > "$state_file"
        fi
        cat "$state_file"
    elif [ -n "$display_num" ]; then
        # External monitor with DDC/CI
        if [ ! -f "$state_file" ]; then
            local brightness=$(ddcutil --bus "$display_num" getvcp 10 -t 2>/dev/null | awk '{print $4}' || echo "100")
            echo "$brightness" > "$state_file"
        fi
        cat "$state_file"
    else
        echo "?"
    fi
}

# Set brightness for a specific monitor
set_brightness() {
    local monitor="$1"
    local new_brightness="$2"
    local state_file=$(get_state_file "$monitor")
    local display_num=$(get_ddcutil_display_bus "$monitor")
    
    if [ "$monitor" = "eDP-1" ]; then
        # Laptop display
        echo "$new_brightness" > "$state_file"
        set_brightness_laptop "$new_brightness"
    elif [ -n "$display_num" ]; then
        # External monitor with DDC/CI
        echo "$new_brightness" > "$state_file"
        set_brightness_ddcutil "$display_num" "$new_brightness"
    else
        # Unsupported monitor
        return
    fi

    notify "$new_brightness"
    
    # Signal all waybar instances
    pkill -RTMIN+8 waybar
}

# Parse command - format: "command [monitor]"
# If monitor not specified, use WAYBAR_OUTPUT_NAME or focused monitor
COMMAND="$1"
MONITOR=$(get_monitor_name "$2")
current=$(get_current_brightness "$MONITOR")

case "$COMMAND" in
    "get")
        echo " $current"
        ;;
    "up")
        if [ "$current" = "?" ]; then
            echo " N/A"
        else
            new_brightness=$((current + STEP > 100 ? 100 : current + STEP))
            if [ "$current" -ne "$new_brightness" ]; then
                set_brightness "$MONITOR" "$new_brightness"
            fi
        fi
        ;;
    "down")
        if [ "$current" = "?" ]; then
            echo " N/A"
        else
            new_brightness=$((current - STEP < 0 ? 0 : current - STEP))
            if [ "$current" -ne "$new_brightness" ]; then
                set_brightness "$MONITOR" "$new_brightness"
            fi
        fi
        ;;
esac
