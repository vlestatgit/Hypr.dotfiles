---------------- Hypr Startup ---------------- >

hl.on("hyprland.start", function()

	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("sleep 0.5 && hyprctl hyprpaper wallpaper ',/home/vlestat/Imagens/Wallpapers/storm.jpg'") -- Set wallpaper

	hl.exec_cmd("waybar")

	hl.exec_cmd("snappy-switcher --daemon")

	hl.exec_cmd("sleep 1 && hyprlock") -- Comment this line if you use sddm or any other display manager for login
	
end)