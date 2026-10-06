# ---------------- Rofi Energy ---------------- >

option=$(
    
    printf "  Performance\n  Balanced\n  Economic" | # Add your menu options here ("Option1\nOption2\nOption3...")
    
    rofi -dmenu -p "  " -theme ~/.config/rofi/mocha.rasi
    
)

case "$option" in

    "  Performance") powerprofilesctl set performance;;
    "  Balanced") powerprofilesctl set balanced;;
    "  Economic") powerprofilesctl set power-saver;;

esac

