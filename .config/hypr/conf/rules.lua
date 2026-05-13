-- ------------------------------------------------
-- AXILLARY FUNCTIONS
-- ------------------------------------------------

-- Float, resize, and center some app
function floatCenterWindow(ruleName, matcher, size)
  size = size or "900 600"

  hl.window_rule({
    name = ruleName,
    match = matcher,

    float = true,
    size = size,
    center = true,
  })
end

-- ------------------------------------------------
-- PROGRAM TAGS
-- ------------------------------------------------

hl.window_rule({ match = { title = "^(Spotify)$" }, tag = "+music" })
hl.window_rule({ match = { class = "org.fooyin.fooyin" }, tag = "+music" })
hl.window_rule({ match = { class = "tidal-hifi" }, tag = "+music" })
hl.window_rule({ match = { class = "obsidian" }, tag = "+notes" })

-- ------------------------------------------------
-- WINDOW RULES
-- ------------------------------------------------

hl.window_rule({ match = { title = [[(.*)([Y|y]outube(.*)]] }, opacity = "1 override" })
hl.window_rule({ match = { title = [[(.*)([N|n]etflix(.*)]] }, opacity = "1 override" })

hl.window_rule({
  name = "Open on note",
  match = { tag = "note" },

  workspace = "special:notes"
})

hl.window_rule({
  name = "Open on music",
  match = { tag = "music" },

  workspace = "special:music"
})

hl.window_rule({
  name = "Float min size",
  match = { float = true },

  center = true,
  min_size = "200 200",
})

hl.window_rule({
  name = "Picture in picture",
  match = {
    title = [[^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$]]
  },

  no_initial_focus = true,
  float = true,
  opacity = "1 override",
  size = "(monitor_w*0.3) (monitor_h*0.3)",
  keep_aspect_ratio = true,
  monitor = "DP-2",
  move = "(monitor_w*0.698) (monitor_h*0.698)",
  pin = true,
})

hl.window_rule({
  name = "kitty",
  match = { class = [[^(kitty)$]] },

  tile = true,
  opacity = "0.85 override",
})

hl.window_rule({
  name = "jetbrains editors",
  match = { class = [[jetbrains-webstorm|jetbrains-idea]] },

  opacity = "1 override",
})

floatCenterWindow("Network Manager Connection Editor", { class = [[nm-connection-editor]] })
floatCenterWindow("Gnome Displays", { class = [[org.gnome.NetworkDisplays]] })
floatCenterWindow("Nautilus", { class = "org.gnome.Nautilus" })
floatCenterWindow("Bitwarden", { class = "Bitwarden" }, "900 800")
floatCenterWindow("CopyQ", { class = "com.github.hluk.copyq" }, "900 800")
floatCenterWindow("Pavucontrol", { class = "org.pulseaudio.pavucontrol" }, "800 650")

hl.window_rule({
  name = "xdg-portals",
  match = { class = [[xdg-desktop-portal.*]] },

  border_size = 0,
  float = true,
  size = "650 600"
})

-- ------------------------------------------------
-- LAYER RULES
-- ------------------------------------------------

hl.layer_rule({
  name = "swaync",
  match = { namespace = [[swaync-control-center]] },

  animation = "slide right",
  blur = true,
  ignore_alpha = 0.1,
})

hl.layer_rule({
  name = "swaync-notification",
  match = { namespace = [[swaync-notification-window]] },

  blur = true,
  ignore_alpha = 0.1,
})

hl.layer_rule({
  name = "wofi",
  match = { namespace = [[wofi]] },

  blur = true,
  ignore_alpha = 0.5,
})

hl.layer_rule({
  name = "waybar",
  match = { namespace = [[waybar]] },

  blur = true,
  ignore_alpha = 0.5,
})

local namespaces_for_no_anim = { "hyprpicker", "selection", "hyprshot" }
for _, value in ipairs(namespaces_for_no_anim) do
  hl.layer_rule({
    match = { namespace = value },
    no_anim = true
  })
end

-- ------------------------------------------------
-- WORKSPACES RULES
-- ------------------------------------------------

hl.workspace_rule({
  workspace = "special:terminal", on_created_empty = "kitty",
})

hl.workspace_rule({
  workspace = "special:notes", on_created_empty = "obsidian",
})

