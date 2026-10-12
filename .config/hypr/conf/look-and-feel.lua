local colors = require("conf.colors")
local util = require("conf.utils.color-opacity")

local activeBorderColor = util.colorWithOpacity(colors.color9, 0.4)
local inactiveBorderColor = util.colorWithOpacity(colors.background, 0.4)
--
-- Look and feel
hl.config({
  general = {
    layout = "dwindle",

    gaps_in = 3,
    gaps_out = 6,
    border_size = 2,

    col = {
      active_border = activeBorderColor,
      inactive_border = inactiveBorderColor,
    }
  },
  decoration = {
    rounding = 12,
    active_opacity = 1.0,
    inactive_opacity = 0.9,
    fullscreen_opacity = 1.0,
    dim_special = 0,

    blur = {
      enabled = true,
      size = 4,
      passes = 4,
      -- variant = "gc",

      new_optimizations = true,
      ignore_opacity = true,
      special = false,
      popups = false,
      popups_ignorealpha = 0.1,
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
    workspace_wraparound = false
  }
})
