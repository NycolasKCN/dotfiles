while inotifywait -e close_write ~/.config/wob/; do
  systemctl --user restart wob.service
  echo 55 > $XDG_RUNTIME_DIR/wob.sock
done
