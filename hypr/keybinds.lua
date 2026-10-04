---------------- Hypr Keybinds ---------------- >

-------- Programs -------- >

local terminal    = "kitty"
local fileManager = "nautilus"
local menu        = "rofi -show drun"
local browser     = "brave"

-------- Shortcuts -------- > 

local super      = "SUPER"
local fn         = "code:135"
local screenshot = "code:107"

hl.bind(super .. " + C", hl.dsp.window.close())

hl.bind(super .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(super .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(super .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(super .. " + SPACE", hl.dsp.exec_cmd(menu))

hl.bind(screenshot .. "", hl.dsp.exec_cmd("hyprshot -m region -o ~/Imagens/$(screenshot.png)"))

hl.bind(super .. " + DELETE", hl.dsp.exec_cmd("hyprlock"))

hl.bind(fn .. " + F3", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5% && [ $(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]+(?=%)' | head -n1) -gt 100 ] && pactl set-sink-volume @DEFAULT_SINK@ 100%"), { repeating = true })
hl.bind(fn .. " + F2", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"), { repeating = true })

hl.bind(fn .. " + up",   hl.dsp.exec_cmd("brightnessctl set +5%"), { repeating = true })
hl.bind(fn .. " + down", hl.dsp.exec_cmd("BRG=$(brightnessctl -m | cut -d, -f4 | tr -d '%'); [ \"$BRG\" -gt 5 ] && brightnessctl set 5%-"), { repeating = true })

-------- Windows -------- > 

hl.bind(super .. " + V", hl.dsp.window.float({ action = "toggle" }))

hl.bind(super .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(super .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("ALT + TAB", hl.dsp.exec_cmd("snappy-switcher next --mod alt"))

-------- Workspaces -------- > 

for i = 1, 10 do

    local key = i % 10

    hl.bind(super .. " + " .. key, hl.dsp.focus({ workspace = i}))
    hl.bind(super .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = i }))

end

hl.bind(super .. " + mouse_up ", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(super .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))

