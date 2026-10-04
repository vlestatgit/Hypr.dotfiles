---------------- Hypr Settings ---------------- >

-------- Monitors -------- >

hl.monitor({

    output   = "eDP-1",
    mode     = "1920x1080@120",
    position = "0x0",
    scale    = "1.0",
    
})

hl.monitor({

    output   = "HDMI-A-1",
    mode     = "1920x1080@200",
    position = "1920x0",
    scale    = "1.0",
    
})

-------- Inputs -------- >

hl.config({

    input = { kb_layout  = "br", },

    dwindle = { preserve_split = true, },

    scrolling = { fullscreen_on_one_column = true, },

    misc = {

        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,

    },

})

