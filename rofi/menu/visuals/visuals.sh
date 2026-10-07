# ---------------- Rofi Visuals ---------------- >

option=$(
    
    printf "  Theme\n  Wallpaper" | #Add your menu options here ("Option1\nOption2\nOption3...")
    
    rofi -dmenu -p "" -theme ~/.config/rofi/mocha.rasi
    
)

case "$option" in

    "  Theme")      ~/.config/rofi/menu/visuals/theme.sh;;
    "  Wallpaper") ~/.config/rofi/menu/visuals/wallpaper.sh;;

esac

