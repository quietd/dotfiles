hl.config({
    input = {
        kb_layout  = "us,us,ru",
        kb_variant = "colemak_dh,,",
        kb_model   = "",
        kb_options = "grp:win_space_toggle",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = true,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "usb-optical-mouse-",
    sensitivity = -0.5,
    accel_profile = flat
})

hl.device({
    name = "msft0001:00-06cb:ce78-touchpad",
    sensitivity = 0.3,
    natural_scroll = true,
    accel_profile = adaptive,
})
