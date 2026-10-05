# ---------------- Rofi System ---------------- >

option=$(
    
    printf "⏻  Energy\n  Modes" | # Add your menu options here ("Option1\nOption2\nOption3...")
    
    rofi -dmenu -p "" -theme ~/.config/rofi/mocha.rasi
    
)

case "$option" in

    "⏻  Energy") ~/.config/rofi/menu/system/energy.sh;;
    "  Modes") ~/.config/rofi/menu/system/modes.sh;;

esac