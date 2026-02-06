#!/bin/bash

DB_CONTAINERS="ale-pessoa-db ale-pessoa-minio"
WEBSTORM_BIN="$HOME/.local/bin/webstorm"
IDEA_BIN="$HOME/.local/bin/idea1"

start_workspace() {
    notify-send -u low "Workspaces" "Starting 'Ale pessoa' dev workspace."

    docker start $DB_CONTAINERS

    hyprctl dispatch exec "[monitor DP-1;workspace 2 silent]" "$WEBSTORM_BIN" ~/projects/ayty/alePessoa/front-end
    hyprctl dispatch exec "[monitor DP-1;workspace 3 silent]" "$IDEA_BIN" ~/projects/ayty/alePessoa/back-end

    notify-send -u low "Workspaces" "Open 'Ale pessoa' dev workspace concluded."
}

stop_workspace() {
    notify-send -u low "Workspaces" "Closing 'Ale pessoa' dev workspace."

    docker stop $DB_CONTAINERS

    pkill -f "webstorm"
    pkill -f "idea"

    notify-send -u low "Workspaces" "Workspace 'Ale pessoa' closed."
}

case "$1" in
    -s|--start)
        start_workspace
        ;;
    -q|--quit|--stop)
        stop_workspace
        ;;
    *)
        echo "Uso: $0 {-s|--start ou -q|--quit}"
        exit 1
        ;;
esac

