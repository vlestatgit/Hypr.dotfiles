# ---------------- Rofi Wallpaper ---------------- >

option=$(
    
    printf "  Storm\n  Waves" | #Add your wallpapers here ("Option1\nOption2\nOption3...")
    
    rofi -dmenu -p "  " -theme ~/.config/rofi/mocha.rasi
    
)

case "$option" in

    "  Storm")

        hyprctl hyprpaper wallpaper ',~/.config/hyprpaper/wallpapers/storm.jpg'
        sed -i '/local wallpaper =/c\local wallpaper = "~/.config/hyprpaper/wallpapers/storm.jpg"' ~/.config/hypr/startup.lua
        sed -i '9s|.*|    path = ~/.config/hyprpaper/wallpapers/storm.jpg # Your wallpaper path|' ~/.config/hypr/hyprlock.conf
        ;;

    "  Waves")

        hyprctl hyprpaper wallpaper ',~/.config/hyprpaper/wallpapers/waves.jpg'
        sed -i '/local wallpaper =/c\local wallpaper = "~/.config/hyprpaper/wallpapers/waves.jpg"' ~/.config/hypr/startup.lua
        sed -i '9s|.*|    path = ~/.config/hyprpaper/wallpapers/waves.jpg # Your wallpaper path|' ~/.config/hypr/hyprlock.conf
        ;;

esac

