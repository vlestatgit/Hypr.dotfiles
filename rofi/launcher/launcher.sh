# ---------------- Rofi Launcher ---------------- >

option=$(
    
    printf "  Favorites\n  Apps" | #Add your menu options here ("Option1\nOption2\nOption3...")
    
    rofi -dmenu -p "" -theme ~/.config/rofi/mocha.rasi
    
)

case "$option" in

    "  Favorites") ~/.config/rofi/launcher/favorites.sh;;
    "  Apps")      rofi -show drun -theme ~/.config/rofi/mocha.rasi;;

esac