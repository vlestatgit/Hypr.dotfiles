---------------- Hypr Keybinds ---------------- >

-------- Programs -------- >

local terminal    = "kitty"
local fileManager = "nautilus"
local browser     = "brave"
local launcher    = "~/.config/rofi/launcher/launcher.sh"
local menu        = "~/.config/rofi/menu/menu.sh"

-------- Shortcuts -------- > 

local super      = "SUPER"
local fn         = "code:135"
local screenshot = "code:107"

hl.bind(super .. " + C", hl.dsp.window.close()) -- Close Window

hl.bind(super .. " + RETURN", hl.dsp.exec_cmd(terminal)) -- Open Terminal
hl.bind(super .. " + E", hl.dsp.exec_cmd(fileManager))   -- Open File Manager
hl.bind(super .. " + B", hl.dsp.exec_cmd(browser))       -- Open Browser
hl.bind(super .. " + SPACE", hl.dsp.exec_cmd(launcher))  -- Open Launcher
hl.bind(super .. " + ESCAPE", hl.dsp.exec_cmd(menu))     -- Open Menu

hl.bind(screenshot .. "", hl.dsp.exec_cmd("hyprshot -m region -o ~/Imagens/$(screenshot.png)")) -- Screenshot

hl.bind(super .. " + DELETE", hl.dsp.exec_cmd("hyprlock")) -- Lock Screen

-- Volume and Brightness

hl.bind(fn .. " + F3", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5% && [ $(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]+(?=%)' | head -n1) -gt 100 ] && pactl set-sink-volume @DEFAULT_SINK@ 100%"), { repeating = true })
hl.bind(fn .. " + F2", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"), { repeating = true })

hl.bind(fn .. " + up",   hl.dsp.exec_cmd("brightnessctl set +5%"), { repeating = true })
hl.bind(fn .. " + down", hl.dsp.exec_cmd("BRG=$(brightnessctl -m | cut -d, -f4 | tr -d '%'); [ \"$BRG\" -gt 5 ] && brightnessctl set 5%-"), { repeating = true })

-------- Windows -------- > 

hl.bind(super .. " + V", hl.dsp.window.float({ action = "toggle" })) -- Toggle Floating

hl.bind(super .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true }) -- Drag Window
hl.bind(super .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- Resize Window

hl.bind("ALT + TAB", hl.dsp.exec_cmd("snappy-switcher next --mod alt")) -- Switch Windows

-------- Workspaces -------- > 

for i = 1, 10 do

    local key = i % 10

    hl.bind(super .. " + " .. key, hl.dsp.focus({ workspace = i}))               -- Focus Workspace (1-10)
    hl.bind(super .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = i })) -- Move Window to Workspace

end

hl.bind(super .. " + mouse_up ", hl.dsp.focus({ workspace = "e+1" }))  -- Focus Next Workspace
hl.bind(super .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" })) -- Focus Previous Workspace

