# ---------------- Rofi Menu ---------------- >

option=$(
    
    printf "⏻  System\n  Connections\n  Theme\n  Favorites" | #Add your menu options here ("Option1\nOption2\nOption3...")
    
    rofi -dmenu -p "" -theme ~/.config/rofi/mocha.rasi
    
)

case "$option" in

    "⏻  System")      ~/.config/rofi/menu/system/system.sh;;
    "  Connections") ;;
    "  Theme")       ;;
    "  Favorites")   ~/.config/rofi/launcher/favorites.sh;;

esac