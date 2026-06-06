local ale = require("conf.launch.ale-pessoa-wp")

local mainMod = "SUPER"
local screenshotOut = "$HOME/Images/Screenshots"

-- APPS AND SCRIPTS
local terminal = "kitty"
local fileManager = "nautilus"
local browser = "zen-browser"
local menu = "wofi -n"
local logout = "wlogout -b 4"

local changeWallpaper = "$HOME/Dotfiles/scripts/wallpaper.sh"
local volume = "$HOME/Dotfiles/scripts/volume.sh"
local recordScreen = "$HOME/Dotfiles/scripts/recordscreen.sh"
local backlight = "$HOME/Dotfiles/scripts/backlight.sh"

-- AUXILLIARY FUNCIONS

local function bindm(keys, dispatcher, flags)
  keys = mainMod .. "+" .. keys
  hl.bind(keys, dispatcher, flags)
end

local function bindm_exec(keys, command, flags)
  bindm(keys, hl.dsp.exec_cmd(command), flags)
end

local function bind_exec(keys, command, flags)
  hl.bind(keys, hl.dsp.exec_cmd(command), flags)
end

-- LAUNCH APPS
bindm_exec("SUPER_L", "pkill wofi ||" .. menu)
bindm_exec("ALT+SPACE", menu)
bindm_exec("SHIFT+B", "bitwarden-desktop")
bindm_exec("CONTROL+V", "pavucontrol -t 3")
bindm_exec("SHIFT+V", "copyq toggle")
bindm_exec("SHIFT+C", "hyprpicker -a -f hex")
bindm_exec("COMMA", changeWallpaper)
bindm_exec("E", fileManager)
bindm_exec("T", terminal)
bindm_exec("B", browser)
bindm_exec("N", "swaync-client -t -sw")
bindm_exec("R", recordScreen)
bindm_exec("ALT+SLASH", logout)

-- Control APPS
bindm("C", hl.dsp.window.close())
bindm("F", hl.dsp.window.float())
bindm("RETURN", hl.dsp.window.fullscreen())
bindm_exec("SHIFT+N", "swaync-client -d")
bindm_exec("SHIFT+L", "pidof hyprlock || hyprlock")
bindm("SHIFT+PERIOD", function()
  hl.exec_cmd("pkill waybar || waybar")
  hl.exec_cmd("pkill swaync || swaync")
end)

bindm("SEMICOLON", function()
  local x = hl.get_monitor_at_cursor().width * 0.5
  local y = hl.get_monitor_at_cursor().height * 0.5
  hl.dispatch(hl.dsp.cursor.move({ x = x, y = y }))
end)

-- LAUNCH WORKSPACES
bindm("PERIOD", hl.dsp.submap("Launch Workspace"))
hl.define_submap("Launch Workspace", function()
  hl.bind("A", function()
    ale.start()
  end)
  hl.bind("CONTROL+A", function()
    ale.stop()
  end)

  hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

-- MOTIONS
bindm("H", hl.dsp.focus({ direction = "l" }))
bindm("L", hl.dsp.focus({ direction = "r" }))
bindm("K", hl.dsp.focus({ direction = "u" }))
bindm("J", hl.dsp.focus({ direction = "d" }))

-- MOVING WINDOWS
bindm("CONTROL+1", hl.dsp.window.move({ workspace = 1 }))
bindm("CONTROL+2", hl.dsp.window.move({ workspace = 2 }))
bindm("CONTROL+3", hl.dsp.window.move({ workspace = 3 }))
bindm("CONTROL+4", hl.dsp.window.move({ workspace = 4 }))
bindm("CONTROL+5", hl.dsp.window.move({ workspace = 5 }))
bindm("CONTROL+6", hl.dsp.window.move({ workspace = 6 }))
bindm("CONTROL+7", hl.dsp.window.move({ workspace = 7 }))
bindm("CONTROL+8", hl.dsp.window.move({ workspace = 8 }))
bindm("CONTROL+9", hl.dsp.window.move({ workspace = 9 }))
bindm("CONTROL+0", hl.dsp.window.move({ workspace = 10 }))
bindm("CONTROL+W", hl.dsp.window.move({ workspace = "special:notes" }))
bindm("CONTROL+S", hl.dsp.window.move({ workspace = "special:music" }))
bindm("CONTROL+Q", hl.dsp.window.move({ workspace = "special:terminal" }))
bindm("CONTROL+G", hl.dsp.window.move({ workspace = "special:magic" }))
bindm("CONTROL+D", hl.dsp.window.move({ workspace = "special:magic2" }))
-- To see the hiden window and workspace you can use:

bindm("CONTROL+H", hl.dsp.window.move({ direction = "l" }))
bindm("CONTROL+L", hl.dsp.window.move({ direction = "r" }))
bindm("CONTROL+K", hl.dsp.window.move({ direction = "u" }))
bindm("CONTROL+J", hl.dsp.window.move({ direction = "d" }))

-- NAVIGATE THROUGH WORKSPACES
bindm("1", hl.dsp.focus({ workspace = 1 }))
bindm("2", hl.dsp.focus({ workspace = 2 }))
bindm("3", hl.dsp.focus({ workspace = 3 }))
bindm("4", hl.dsp.focus({ workspace = 4 }))
bindm("5", hl.dsp.focus({ workspace = 5 }))
bindm("6", hl.dsp.focus({ workspace = 6 }))
bindm("7", hl.dsp.focus({ workspace = 7 }))
bindm("8", hl.dsp.focus({ workspace = 8 }))
bindm("9", hl.dsp.focus({ workspace = 9 }))
bindm("0", hl.dsp.focus({ workspace = 10 }))
bindm("W", hl.dsp.workspace.toggle_special("notes"))
bindm("S", hl.dsp.workspace.toggle_special("music"))
bindm("Q", hl.dsp.workspace.toggle_special("terminal"))
bindm("G", hl.dsp.workspace.toggle_special("magic"))
bindm("D", hl.dsp.workspace.toggle_special("magic2"))

-- Layouts
bindm("P", hl.dsp.layout("togglesplit"))

-- MOVE | RESIZE | TOGGLE FLOATING WINDOWS
bindm("mouse:272", hl.dsp.window.drag(), { mouse = true })
bindm("mouse:273", hl.dsp.window.resize(), { mouse = true })
bindm("mouse:273", hl.dsp.window.float(), { mouse = true, click = true })

-- OUTPUT VOLUME CONTROL
bind_exec("XF86AudioLowerVolume", volume .. " --dec --notify", { repeating = true })
bind_exec("XF86AudioRaiseVolume", volume .. " --inc --notify", { repeating = true })

-- INPUT VOLUME CONTROL
bind_exec("SHIFT+XF86AudioLowerVolume", volume .. " --dec-mic --notify", { repeating = true })
bind_exec("SHIFT+XF86AudioRaiseVolume", volume .. " --inc-mic --notify", { repeating = true })

-- TOGGLE AUDIO
bindm_exec("x", volume .. " --toggle", { locked = true })
bindm_exec("z", volume .. " --toggle-mic", { locked = true })
bind_exec("XF86AudioMute", volume .. " --toggle", { locked = true })
bind_exec("XF86AudioMicMute", volume .. " --toggle-mic", { locked = true })

-- MEDIA CONTROL
bind_exec("XF86AudioPlay", "playerctl -p fooyin,%any,chromium,firefox play-pause", { locked = true })
bind_exec("XF86AudioPrev", "playerctl -p fooyin,%any,chromium,firefox previous", { locked = true })
bind_exec("XF86AudioNext", "playerctl -p fooyin,%any,chromium,firefox next", { locked = true })

-- DISPLAY BACKLIGHT
bind_exec("XF86MonBrightnessUp", backlight .. " --inc")
bind_exec("XF86MonBrightnessDown", backlight .." --dec")

-- ZOOM IN AND OUT

local zoomIn =
"hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end')"
local zoomOut = "hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1')"

bindm_exec("mouse_down", zoomIn)
bindm_exec("mouse_down", zoomOut)

-- SCREENSHOT
bindm_exec("SHIFT+s", "hyprshot -z -m region -o " .. screenshotOut)
