---------------- Hypr Startup ---------------- >

local wallpaper = "~/.config/hyprpaper/wallpapers/waves.jpg"

hl.on("hyprland.start", function()

	hl.exec_cmd("hyprpaper") hl.exec_cmd("sleep 1 && hyprctl hyprpaper wallpaper '," .. wallpaper .. "'") -- Your Wallpaper

	hl.exec_cmd("sleep 1 && hyprlock") -- Comment this line if you use sddm or any other display manager for login

	hl.exec_cmd("waybar")

	hl.exec_cmd("snappy-switcher --daemon")
	
end)

