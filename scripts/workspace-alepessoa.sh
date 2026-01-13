#!/bin/bash

notify-send -u low "Workspaces" "Starting 'Ale pessoa' dev workspace."

docker start ale-pessoa-db ale-pessoa-minio
hyprctl dispatch exec "[workspace 2 silent]" webstorm ~/projects/ayty/alePessoa/front-end
hyprctl dispatch exec "[workspace 3 silent]" idea1 ~/projects/ayty/alePessoa/back-end

notify-send -u low "Workspaces" "Open 'Ale pessoa' dev workspace concluded."
