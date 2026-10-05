# ---------------- Rofi Menu ---------------- >

option=$(
    
    printf "⏻  System\n  Connections\n  Theme\n  Apps\n  Favorites" | #Add your menu options here ("Option1\nOption2\nOption3...")
    
    rofi -dmenu -p "" -theme ~/.config/rofi/mocha.rasi
    
)

case "$option" in

    "⏻  System")      ~/.config/rofi/menu/system/system.sh;;
    "  Connections") ~/.config/rofi/menu/connections/connections.sh;;
    "  Theme")       ;;
    "  Apps")        rofi -show drun -theme ~/.config/rofi/mocha.rasi;;
    "  Favorites")   ~/.config/rofi/favorites.sh;;

esac

