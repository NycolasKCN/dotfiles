#!/bin/bash

notify-send -u low "Workspaces" "Starting 'Ale pessoa' dev workspace."

docker start ale-pessoa-db ale-pessoa-minio

hyprctl dispatch exec "[monitor DP-1;workspace 2 silent]" ~/.local/bin/webstorm ~/projects/ayty/alePessoa/front-end
hyprctl dispatch exec "[monitor DP-1;workspace 3 silent]" ~/.local/bin/idea1 ~/projects/ayty/alePessoa/back-end

notify-send -u low "Workspaces" "Open 'Ale pessoa' dev workspace concluded."
