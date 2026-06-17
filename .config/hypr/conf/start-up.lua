local host = require("conf.utils.host")

hl.on("hyprland.start", function()
  -- hl.exec_cmd("obsidian", {
  --   workspace = "special:notes",
  --   silent = true
  -- })
  -- hl.exec_cmd("fooyin", {
  --   workspace = "special:music",
  --   silent = true
  -- })

  hl.exec_cmd("systemctl --user start hyprland-session.target")

  hl.exec_cmd("wal - R")
  hl.exec_cmd("sleep 2 & waybar")
  hl.exec_cmd("nm-applet & copyq --start-server")
  if host.isLaptop() then
    hl.exec_cmd("blueman-applet")
  end

  hl.exec_cmd("udiskie")
  hl.exec_cmd("swaync & swaync-client -df")
  hl.exec_cmd("udiskie")
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
  hl.exec_cmd("kdeconnectd & kdeconnect-indicator")
  hl.exec_cmd("hyprpaper & hypridle")
end)

hl.on("hyprland.shutdown", function()
  os.execute("systemctl --user stop hyprland-session.target && sleep 0.1")
  -- uses a blocking exec function and sleeps a bit to give things time to close
  -- you might also want to kill troublesome/crashing non-systemd background services here:
  -- os.execute("pkill wallpaperthing; systemctl --user stop hyprland-session.target && sleep 0.1")
end)
