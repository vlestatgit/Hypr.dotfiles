---------------- Hypr Rules ---------------- >

-------- Windows -------- >

local suppressMaximizeRule = hl.window_rule({
    
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",

})

hl.window_rule({

    name  = "fix-xwayland-drags",

    match = {

        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,

    },

    no_focus = true,

})

hl.window_rule({

    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,

})

-------- Workspaces -------- >

for i = 1, 5 do

    hl.workspace_rule({

        workspace  = tostring(i),
        persistent = true,

        monitor = "eDP-1",

    })

end

for i = 6, 10 do

    hl.workspace_rule({

        workspace  = tostring(i),
        persistent = true,

        monitor = "HDMI-A-1",

    })

end

-------- Blur -------- >

hl.layer_rule({

    match = { namespace = "rofi" },

    blur = true,
    ignore_alpha = 0.75

})

hl.layer_rule({

    match = { namespace = "snappy-switcher" },

    blur = true,
    ignore_alpha = 0.75
    
})