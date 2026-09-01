hl.config({
  general = {
    border_size = 1,
    gaps_in = 3,
    gaps_out = 4,
    float_gaps = 0,
    gaps_workspaces = 0,
    col = {
      active_border = {colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45},
      inactive_border = "rgba(595959aa)",
      nogroup_border = 0xffffaaff,
      nogroup_border_active = 0xffff00ff,
    },
    layout = "dwindle",
    no_focus_fallback = false,
    resize_on_border = false,
    extend_border_grab_area = 15,
    hover_icon_on_border = true,
    allow_tearing = true,
    resize_corner = 0,
    modal_parent_blocking = true,

    snap = {
      enabled = false,
      window_gap = 10,
      monitor_gap = 10,
      border_overlap = false,
      respect_gaps = false
    }
  }
})
