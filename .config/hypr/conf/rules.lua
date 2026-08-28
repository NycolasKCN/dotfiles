-- ------------------------------------------------
-- AXILLARY FUNCTIONS
-- ------------------------------------------------

-- Float, resize, and center some app
---@param ruleName string
---@param matcher table
---@param size string?
local function floatCenterWindow(ruleName, matcher, size)
	size = size or "900 600"

	hl.window_rule({
		name = ruleName,
		match = matcher,

		float = true,
		size = size,
		center = true,
	})
end

-- This function register an trigger event to float a window of an app already open
---@param title string Full window title
---@param size table? the window new size (x, y)
local function setFloatWindow(title, size)
	hl.on("window.title", function(window)
		if window ~= nil and window.title == title then
			hl.dispatch(hl.dsp.window.float({ action = "set", window = window }))
			hl.dispatch(hl.dsp.window.center({ window = window }))

			if size then
				hl.dispatch(hl.dsp.window.resize(size))
			end
		end
	end)
end

-- ------------------------------------------------
-- PROGRAM TAGS
-- ------------------------------------------------

hl.window_rule({ match = { title = "^(Spotify)$" }, tag = "+music" })
hl.window_rule({ match = { class = "org.fooyin.fooyin" }, tag = "+music" })
hl.window_rule({ match = { class = "tidal-hifi" }, tag = "+music" })
hl.window_rule({ match = { class = "kopuz" }, tag = "+music" })
hl.window_rule({ match = { class = ".*[oO]bsidian.*" }, tag = "+notes" })
hl.window_rule({ match = { class = "ZenNotes" }, tag = "+notes" })

-- ------------------------------------------------
-- WINDOW RULES
-- ------------------------------------------------

hl.window_rule({
	name = "Open on special:notes",
	match = { tag = "notes" },

	workspace = "special:notes",
})

hl.window_rule({
	name = "Open on special:music",
	match = { tag = "music" },

	workspace = "special:music",
})

hl.window_rule({
	name = "Remove shadow on tiled windows",
	match = { float = false },
	no_shadow = true,
})

hl.window_rule({
	name = "Picture in picture",
	match = {
		title = [[^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$]],
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

-- Jetbrains editors
hl.window_rule({
	name = "jetbrains editors",
	match = { class = [[jetbrains-webstorm|jetbrains-idea]] },

	opacity = "1 override",
})
hl.window_rule({
	name = "Open on workspace 2",
	match = { class = [[jetbrains-webstorm]] },
	workspace = "2 silent",
})
hl.window_rule({
	name = "Open on workspace 3",
	match = { class = [[jetbrains-idea]] },
	workspace = "3 silent",
})
-- Jetbrains editors

-- Other apps
hl.window_rule({ match = { title = [[(.*)YouTube(.*)]] }, opacity = "1 override" })
hl.window_rule({ match = { title = [[(.*)Netflix(.*)]] }, opacity = "1 override" })

hl.window_rule({
	name = "blender file view",
	match = { title = "Blender File View" },

	center = true,
	min_size = "800 800",
})

hl.window_rule({
	name = "kitty",
	match = { class = [[^(kitty)$]] },

	tile = true,
	opacity = "0.85 override",
})

hl.window_rule({
	name = "vlc",
	match = { class = [[vlc]] },

	center = false,
	no_blur = true,
	opacity = "1 override",
  min_size = "0 0"
})
-- Other apps

-- Float rules
hl.window_rule({
	name = "Float min size",
	match = { float = true },

	min_size = "200 200",
})
floatCenterWindow("Network Manager Connection Editor", { class = [[nm-connection-editor]] })
floatCenterWindow("Gnome Displays", { class = [[org.gnome.NetworkDisplays]] })
floatCenterWindow("Nautilus", { class = "org.gnome.Nautilus" })
floatCenterWindow("Bitwarden", { class = "Bitwarden" }, "900 800")
floatCenterWindow("CopyQ", { class = "com.github.hluk.copyq" }, "900 800")
floatCenterWindow("Pavucontrol", { class = "org.pulseaudio.pavucontrol" }, "800 650")

-- Float bitwarden popup on firefox
-- setFloatWindow([[[Ee]xtension.*[Bb]itwarden.*]], {x = 800, y = 600})
setFloatWindow("Extension: (Bitwarden Password Manager) - Bitwarden — Zen Browser", { x = 800, y = 600 })

hl.window_rule({
	name = "xdg-portals",
	match = { class = [[xdg-desktop-portal.*]] },

	border_size = 0,
	float = true,
	size = "650 600",
})

hl.window_rule({
	name = "wofi",
	match = { class = [[wofi]] },

	border_size = 0,
	animation = "slide bottom",
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
	animation = "slide right",
})

hl.layer_rule({
	name = "wofi",
	match = { namespace = [[wofi]] },

	blur = true,
	ignore_alpha = 0.1,
})

hl.layer_rule({
	name = "vicinae",
	match = { namespace = [[vicinae]] },

	blur = true,
	ignore_alpha = 0.1,
})

hl.layer_rule({
	name = "waybar",
	match = { namespace = [[waybar]] },

	blur = true,
	ignore_alpha = 0.4,
	animation = "slide top",
})

hl.layer_rule({
	name = "wlogout",
	match = { namespace = [[logout_dialog]] },

	blur = true,
	ignore_alpha = 0.2,
})

hl.layer_rule({
	name = "ycal",
	match = { namespace = [[gtk4-layer-shell]] },

	blur = true,
	ignore_alpha = 0.2,
	animation = "slide top",
})

hl.layer_rule({
	name = "wob",
	match = { namespace = [[wob]] },

	blur = true,
	ignore_alpha = 0.2,
	animation = "slide bottom",
})

local namespaces_for_no_anim = { "hyprpicker", "selection", "hyprshot" }
for _, value in ipairs(namespaces_for_no_anim) do
	hl.layer_rule({
		match = { namespace = value },
		no_anim = true,
	})
end

-- ------------------------------------------------
-- WORKSPACES RULES
-- ------------------------------------------------

hl.workspace_rule({
	workspace = "special:terminal",
	on_created_empty = "kitty",
})

-- hl.workspace_rule({
--   workspace = "special:notes", on_created_empty = "obsidian",
-- })

-- No border when alone in screen
hl.window_rule({
	match = { float = false, workspace = "w[tv1]" },
	border_size = 1,
})
hl.window_rule({
	match = { float = false, workspace = "f[1]" },
	border_size = 1,
})

-- ------------------------------------------------
-- EVENTS
-- ------------------------------------------------
