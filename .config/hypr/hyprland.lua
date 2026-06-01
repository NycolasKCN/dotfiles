-- Enviroment variables
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "20")
hl.env("HYPRCURSOR_SIZE", "20")
hl.env("XCOMPOSEFILE", "$HOME/.XCompose")

-- -- XDG Desktop Portal
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- -- QT
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")

-- -- GDK
hl.env("GDK_SCALE", "1")

-- -- Toolkit Backend
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("CLUTTER_BACKEND", "wayland")

-- -- Mozilla
hl.env("MOZ_ENABLE_WAYLAND", "1")

-- -- Ozone
hl.env("OZONE_PLATFORM", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- -- Nvidia
local host = require("conf.utils.host")
if host.isDesktop() then
  hl.env("LIBVA_DRIVER_NAME", "nvidia")
  hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
end
-- ------------------------------------------------

-- General Config
hl.config({
  general = {
    -- snap = {
    --   enable = true,
    --   monitor_gap = 15,
    -- }
  },
  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo = 1,
  },
  xwayland = {
    force_zero_scaling = true
  },
  binds = {
    drag_threshold = 16,
  },
})

-- Configs
require("conf.animations")
require("conf.start-up")
require("conf.inputs")
require("conf.look-and-feel")
require("conf.rules")
require("conf.keybinds")

-- Nwg displays
require("monitors")
require("workspaces")
