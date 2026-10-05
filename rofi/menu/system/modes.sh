# ---------------- Rofi Energy ---------------- >

option=$(
    
    printf "  Performance\n  Balanced\n  Economic" | # Add your menu options here ("Option1\nOption2\nOption3...")
    
    rofi -dmenu -p "" -theme ~/.config/rofi/mocha.rasi
    
)

case "$option" in

    "  Performance") hyprctl setoption general:power_profile performance;;
    "  Balanced") hyprctl setoption general:power_profile balanced;;
    "  Economic") hyprctl setoption general:power_profile economic;;

esac