# ---------------- Rofi Energy ---------------- >

option=$(
    
    printf "⏻  Shut down\n  Reboot\n  Lock Screen" | # Add your menu options here ("Option1\nOption2\nOption3...")
    
    rofi -dmenu -p "" -theme ~/.config/rofi/mocha.rasi
    
)

case "$option" in

    "⏻  Shut down") shutdown now;;
    "  Reboot") reboot;;
    "  Lock Screen") hyprlock;;

esac