-- Inputs
hl.config({
  input = {
    -- Keyboard
    numlock_by_default = true,
    kb_layout = "us",
    kb_variant = "intl",
    repeat_rate = 60,
    repeat_delay = 250,

    -- Mouse and touchpad
    follow_mouse = 1,
    float_switch_override_focus = 2,
    sensitivity = -0.6 -- -1.0 - 1.0, 0 means no modification.
  }
})

-- Cursor
hl.config({
  cursor = {
    inactive_timeout = 3,
    warp_on_change_workspace = 1,
    warp_on_toggle_special = 1,
  },
})

-- Devices
hl.device({
  name = "synps/2-synaptics-touchpad",
  natural_scroll = false,
  sensitivity = 0,
  accel_profile = "adaptative",
})

hl.device({
  name = "by-tech-gaming-keyboard",
  kb_options = "altwin:swap_alt_win,caps:menu,shift:both_capslock_cancel",
})

hl.device({
  name = "at-translated-set-2-keyboard",
  kb_options = "caps:none,shift:both_capslock_cancel",
})

-- Gestures
hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace",
})
