-- Look and feel
hl.config({
  general = {
    layout = "dwindle",

    gaps_in = 3,
    gaps_out = 4,
    border_size = 1,

    col = {
      active_border = "rgba(22222250)",
      inactive_border = "rgba(22222250)",
    }
  },
  decoration = {
    rounding = 10,
    active_opacity = 1.0,
    inactive_opacity = 0.9,
    fullscreen_opacity = 1.0,
    dim_special = 0,

    blur = {
      enabled = true,
      size = 4,
      passes = 4,

      new_optimizations = true,
      ignore_opacity = true,
      special = false,
    },

    shadow = {
      enabled = true,
      range = 32,
      render_power = 2,
      color = "rgba(00000050)",
    },
  },

  animations = {
    enabled = true,
    workspace_wraparound = true
  }
})
