-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
local cfg = require("configs.variables")
local rofi_theme = "/home/gaurav/.config/rofi/launchers/type-1/style-3.rasi"
local screenshot_dir = "/home/gaurav/Pictures/Screenshots"

hl.bind(cfg.mod .. " + RETURN", hl.dsp.exec_cmd(cfg.apps.terminal))
local closeWindowBind = hl.bind(cfg.mod .. " + Q", hl.dsp.window.close())
hl.bind(cfg.mod .. " + SHIFT + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(cfg.mod .. " + B", hl.dsp.exec_cmd(cfg.apps.fileManager))
hl.bind(cfg.mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(cfg.mod .. " + M", hl.dsp.exec_cmd("~/.config/rofi/launchers/type-1/launcher.sh"))
hl.bind(cfg.mod .. " + P", hl.dsp.window.pseudo())
hl.bind(cfg.mod .. " + E", hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind(cfg.mod .. " + F", hl.dsp.window.fullscreen())
hl.bind(cfg.mod .. " + SHIFT + L", hl.dsp.exec_cmd("swaylock --color 000000"))
hl.bind(cfg.mod .. " + C", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"))
hl.bind(cfg.mod .. " + O", hl.dsp.exec_cmd("~/scripts/rofi_sys"))
hl.bind(cfg.mod .. " + T", hl.dsp.exec_cmd("kitty -e ~/scripts/tmux-sessionizer"))
hl.bind(cfg.mod .. " + N", hl.dsp.exec_cmd("qutebrowser"))
hl.bind(cfg.mod .. " + SHIFT + H", hl.dsp.layout("swapsplit"))
hl.bind(cfg.mod .. " + UP", hl.dsp.exec_cmd("busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n -200"))
hl.bind(cfg.mod .. " + DOWN", hl.dsp.exec_cmd("busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n +200"))
hl.bind(cfg.mod .. " + Z", hl.dsp.exec_cmd("~/scripts/book-open.sh"))
hl.bind(cfg.mod .. " + D", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | tesseract stdin stdout -l eng | wl-copy]]))
hl.bind(cfg.mod .. " + Tab", function()
    -- Change focus to another window
    hl.dispatch(hl.dsp.window.cycle_next())
    -- Bring it to the top 
    hl.dispatch(hl.dsp.window.bring_to_top())
end)



hl.bind(cfg.mod .. " + R", hl.dsp.submap("resize"))

hl.define_submap("resize", function()
    hl.bind("H", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
    hl.bind("J", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
    hl.bind("K", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
    hl.bind("L", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })

    hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

-- Move focus with cfg.mod + arrow keys
hl.bind(cfg.mod .. " + H",  hl.dsp.focus({ direction = "left" }))
hl.bind(cfg.mod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(cfg.mod .. " + K",    hl.dsp.focus({ direction = "up" }))
hl.bind(cfg.mod .. " + J",  hl.dsp.focus({ direction = "down" }))


hl.bind(cfg.mod .. " + Y",
    hl.dsp.exec_cmd(
        "cliphist list | rofi -dmenu -theme " .. rofi_theme .. " -display-columns 2 | cliphist decode | wl-copy"
    )
)

hl.bind(cfg.mod .. " + SHIFT + Y",
    hl.dsp.exec_cmd(
        "cliphist list | rofi -dmenu -theme " .. rofi_theme .. " | cliphist delete"
    )
)

hl.bind(
    cfg.mod .. " + I",
    hl.dsp.exec_cmd(
        "rofimoji --selector-args='-theme " .. rofi_theme .. "'"
    )
)

-- Symbol picker: update Python 3.x path if Arch changes Python version
hl.bind(
    cfg.mod .. " + SHIFT + I",
    hl.dsp.exec_cmd(
        "rofimoji --files " ..
        "/usr/lib/python3.14/site-packages/picker/data/arrows.csv " ..
        "/usr/lib/python3.14/site-packages/picker/data/currency_symbols.csv " ..
        "/usr/lib/python3.14/site-packages/picker/data/general_punctuation.csv " ..
        "/usr/lib/python3.14/site-packages/picker/data/letterlike_symbols.csv " ..
        "/usr/lib/python3.14/site-packages/picker/data/math.csv " ..
        "/usr/lib/python3.14/site-packages/picker/data/mathematical_operators.csv " ..
        "/usr/lib/python3.14/site-packages/picker/data/geometric_shapes.csv " ..
        "/usr/lib/python3.14/site-packages/picker/data/superscripts_and_subscripts.csv " ..
        "/usr/lib/python3.14/site-packages/picker/data/supplemental_arrows-a.csv " ..
        "/usr/lib/python3.14/site-packages/picker/data/supplemental_arrows-b.csv " ..
        "/usr/lib/python3.14/site-packages/picker/data/supplemental_mathematical_operators.csv " ..
        "/usr/lib/python3.14/site-packages/picker/data/supplemental_punctuation.csv " ..
        "/usr/lib/python3.14/site-packages/picker/data/miscellaneous_symbols.csv " ..
        "/usr/lib/python3.14/site-packages/picker/data/miscellaneous_symbols_and_arrows.csv " ..
        "/usr/lib/python3.14/site-packages/picker/data/dingbats.csv " ..
        "--prompt 'Symbols ' " ..
        "--selector-args='-theme " .. rofi_theme .. "'"
    )
)

hl.bind(
    "PRINT",
    hl.dsp.exec_cmd(
        "file=" .. screenshot_dir .. "/$(date +%Y-%m-%d_%H-%M-%S).png; grim \"$file\" && wl-copy < \"$file\" && notify-send 'Screenshot' 'Saved and copied to clipboard'"
    )
)

hl.bind(
    cfg.mod .. " + SHIFT + U",
    hl.dsp.exec_cmd(
        "file=" .. screenshot_dir .. "/$(date +%Y-%m-%d_%H-%M-%S).png; grim \"$file\" && wl-copy < \"$file\" && notify-send 'Screenshot' 'Saved and copied to clipboard'"
    )
)

hl.bind(
    cfg.mod .. " + U",
    hl.dsp.exec_cmd(
        "REGION=$(slurp) && grim -g \"$REGION\" - | wl-copy && notify-send 'Screenshot copied to clipboard'"
    )
)

hl.bind(
    cfg.mod .. " + BRACKETRIGHT",
    hl.dsp.exec_cmd(
        [[hyprctl eval "hl.config { cursor = { zoom_factor = $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.25') } }"]]
    )
)

hl.bind(
    cfg.mod .. " + BRACKETLEFT",
    hl.dsp.exec_cmd(
        [[hyprctl eval "hl.config { cursor = { zoom_factor = $(hyprctl getoption cursor:zoom_factor -j | jq '(.float / 1.25) | if . < 1 then 1 else . end') } }"]]
    )
)

hl.bind(
    cfg.mod .. " + mouse:276",
    hl.dsp.exec_cmd(
        [[hyprctl eval "hl.config { cursor = { zoom_factor = $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.25') } }"]]
    )
)

hl.bind(
    cfg.mod .. " + mouse:275",
    hl.dsp.exec_cmd(
        [[hyprctl eval "hl.config { cursor = { zoom_factor = $(hyprctl getoption cursor:zoom_factor -j | jq '(.float / 1.25) | if . < 1 then 1 else . end') } }"]]
    )
)

-- Switch workspaces with cfg.mod + [0-9]
-- Move active window to a workspace with cfg.mod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(cfg.mod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(cfg.mod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(cfg.mod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(cfg.mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with cfg.mod + scroll
hl.bind(cfg.mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(cfg.mod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with cfg.mod + LMB/RMB and dragging
hl.bind(cfg.mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(cfg.mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(cfg.mod .. " + G", hl.dsp.exec_cmd(
    [[hyprctl eval 'hl.config { cursor = { inactive_timeout = 0, hide_on_key_press = false } }' && hyprctl dispatch 'hl.dsp.submap("cursor")']]
))

hl.define_submap("cursor", function()
    hl.bind("A", hl.dsp.exec_cmd(
        [[hyprctl dispatch 'hl.dsp.submap("reset")' && wl-kbptr && hyprctl dispatch 'hl.dsp.submap("cursor")']]
    ))

    hl.bind("J", hl.dsp.exec_cmd("wlrctl pointer move 0 10"),  { repeating = true })
    hl.bind("K", hl.dsp.exec_cmd("wlrctl pointer move 0 -10"), { repeating = true })
    hl.bind("L", hl.dsp.exec_cmd("wlrctl pointer move 10 0"),  { repeating = true })
    hl.bind("H", hl.dsp.exec_cmd("wlrctl pointer move -10 0"), { repeating = true })
    
    -- fast nudge (shift)
    hl.bind("SHIFT + J", hl.dsp.exec_cmd("wlrctl pointer move 0 40"),  { repeating = true })
    hl.bind("SHIFT + K", hl.dsp.exec_cmd("wlrctl pointer move 0 -40"), { repeating = true })
    hl.bind("SHIFT + L", hl.dsp.exec_cmd("wlrctl pointer move 40 0"),  { repeating = true })
    hl.bind("SHIFT + H", hl.dsp.exec_cmd("wlrctl pointer move -40 0"), { repeating = true })

    hl.bind("R", hl.dsp.exec_cmd("hyprctl dispatch click left"))
    hl.bind("S", hl.dsp.exec_cmd("wlrctl pointer click middle"))
    hl.bind("T", hl.dsp.exec_cmd("wlrctl pointer click right"))

    hl.bind("ESCAPE", hl.dsp.exec_cmd(
        [[hyprctl eval 'hl.config { cursor = { inactive_timeout = 3, hide_on_key_press = true } }' && hyprctl dispatch 'hl.dsp.submap("reset")']]
    ))
end)

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })
hl.bind("XF86Calculator",hl.dsp.exec_cmd("qalculate-gtk"),                                         { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
