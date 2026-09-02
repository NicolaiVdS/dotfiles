hl.config({
  decoration = {
    rounding = 0,
    rounding_power = 1.0,
    active_opacity = 1,
    inactive_opacity = 0.7,
    fullscreen_opacity = 1,
    dim_modal = true,
    dim_inactive = false,
    dim_strength = 0.5,
    dim_special = 0.2,
    dim_around = 0.4,

    blur = {
      enabled = true,
      size = 8,
      passes = 1,
      ignore_opacity = true,
      new_optimizations = true,
      xray = true,
      noise = 0.0117,
      contrast = 0.8172,
      brightness = 1,
      vibrancy = 0.1696,
      vibrancy_darkness = 0.0,
      special = false,
      popups = false,
      popups_ignorealpha = 0.2,
      input_methods = false,
      input_methods_ignorealpha = 0.2
    },

    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      sharp = false,
      color = 0xee1a1a1a,
      offset = {0,0},
      scale = 1
    }
 }
})
