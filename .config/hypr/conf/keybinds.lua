local ale = require("conf.launch.ale-pessoa-wp")
local functions = require("conf.keybinds-functions")

local bindm, bindm_exec, bind_exec = functions.bindm, functions.bindm_exec, functions.bind_exec
local zoom =  functions.zoom
local toggle_float_focus, toggle_pin_nofocus, toggle_pin =
	functions.toggle_float_focus, functions.toggle_pin_nofocus, functions.toggle_pin


-- APPS, SCRIPTS and PATHS
local terminal = "kitty"
local fileManager = "nautilus"
local browser = "zen-browser"
local menu = "vicinae toggle"
local menuBack = "pkill wofi || wofi drun"
local logout = "wlogout -b 5"

local changeWallpaper = "$HOME/Dotfiles/scripts/wallpaper.sh"
local volume = "$HOME/Dotfiles/scripts/volume.sh"
local toggleAudio = "$HOME/Dotfiles/scripts/toggle-desktop-source.sh toggle"
local recordScreen = "$HOME/Dotfiles/scripts/recordscreen.sh"
local brightness = "$HOME/Dotfiles/scripts/brightness.sh"

local screenshotOut = "$HOME/Images/Screenshots"

-- quickshell
local notificationCenter = "qs ipc call notifications toggle"
local toggleDnd = "qs ipc call notifications toggleDnd"

-- Devices
local fizz_kbd = { inclusive = true, list = { "by-tech-gaming-keyboard" } }

-- AUXILLIARY FUNCIONS
-- LAUNCH APPS
bindm_exec("", menu, { release = true })
bindm_exec("SHIFT", menuBack, { release = true })
bind_exec("ALT+TAB", "vicinae vicinae://launch/wm/switch-windows")
bind_exec("ALT+SPACE", menu)
bindm_exec("SHIFT+B", "bitwarden-desktop")
bindm_exec("CONTROL+V", "pkill pavucontrol || pavucontrol -t 3")
bindm_exec("SHIFT+V", "vicinae vicinae://launch/clipboard/history")
bindm_exec("SHIFT+C", "hyprpicker -a -f hex")
bindm_exec("COMMA", changeWallpaper)
bindm_exec("E", fileManager)
bindm_exec("T", terminal)
bindm_exec("B", browser)
bindm_exec("N", notificationCenter)
bindm_exec("R", recordScreen)
bindm_exec("SEMICOLON", logout)

-- Control APPS
bindm("C", hl.dsp.window.close())
bindm("F", hl.dsp.window.float())
bindm("RETURN", hl.dsp.window.fullscreen())
bindm_exec("SHIFT+N", toggleDnd)
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

-- MOVE | RESIZE | TOGGLE FLOATING WINDOWS | TOGGLE PIN WINDOW
bindm("mouse:276", toggle_pin_nofocus, { mouse = true })
bindm("mouse:275", toggle_pin, { mouse = true })
bindm("mouse:272", hl.dsp.window.drag(), { mouse = true })
bindm("mouse:273", hl.dsp.window.resize(), { mouse = true })
bindm("mouse:273", hl.dsp.window.float(), { click = true })
bindm("ALT+H", hl.dsp.window.resize({ x = -12, y = 0, relative = true }), { repeating = true })
bindm("ALT+J", hl.dsp.window.resize({ x = 0, y = 12, relative = true }), { repeating = true })
bindm("ALT+K", hl.dsp.window.resize({ x = 0, y = -12, relative = true }), { repeating = true })
bindm("ALT+L", hl.dsp.window.resize({ x = 12, y = 0, relative = true }), { repeating = true })

-- OUTPUT VOLUME CONTROL
bind_exec("XF86AudioLowerVolume", volume .. " --dec --notify", { repeating = true })
bind_exec("XF86AudioRaiseVolume", volume .. " --inc --notify", { repeating = true })
-- output just for FizzKeyboard
bind_exec("F11", volume .. " --dec --notify", { repeating = true, device = fizz_kbd })
bind_exec("F12", volume .. " --inc --notify", { repeating = true, device = fizz_kbd })

-- INPUT VOLUME CONTROL
bind_exec("SHIFT+XF86AudioLowerVolume", volume .. " --dec-mic --notify", { repeating = true })
bind_exec("SHIFT+XF86AudioRaiseVolume", volume .. " --inc-mic --notify", { repeating = true })

-- TOGGLE AUDIO
bindm_exec("x", volume .. " --toggle", { locked = true })
bindm_exec("z", volume .. " --toggle-mic", { locked = true })
bind_exec("XF86AudioMute", volume .. " --toggle", { locked = true })
bind_exec("XF86AudioMicMute", volume .. " --toggle-mic", { locked = true })

-- TOGGLE AUDIO SOURCE AND SINK
bindm_exec("SHIFT+z", toggleAudio)

-- MEDIA CONTROL
bind_exec("XF86AudioPlay", "playerctl -p fooyin,%any,chromium,firefox play-pause", { locked = true })
bind_exec("XF86AudioPrev", "playerctl -p fooyin,%any,chromium,firefox previous", { locked = true })
bind_exec("XF86AudioNext", "playerctl -p fooyin,%any,chromium,firefox next", { locked = true })

-- DISPLAY BACKLIGHT
bind_exec("XF86MonBrightnessUp", brightness .. " up")
bind_exec("XF86MonBrightnessDown", brightness .. " down")

-- ZOOM IN AND OUT
bindm("mouse_up", function()
	zoom(0.25)
end, { mouse = true })
bindm("mouse_down", function()
	zoom(-0.25)
end, { mouse = true })

-- SCREENSHOT
bindm_exec("SHIFT+s", "hyprshot -z -m region -o " .. screenshotOut)
bindm("SPACE", toggle_float_focus, { description = "Switch focus between tiled and floating windows" })
