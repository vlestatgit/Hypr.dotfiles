# ---------------- Rofi Connections ---------------- >

option=$(
    
    printf "󰤨  Wifi\n󰂯  Bluetooth" | #Add your menu options here ("Option1\nOption2\nOption3...")
    
    rofi -dmenu -p "" -theme ~/.config/rofi/mocha.rasi
    
)

case "$option" in

    "󰤨  Wifi")      ~/.config/rofi/menu/connections/wifi.sh;;
    "󰂯  Bluetooth") ~/.config/rofi/menu/connections/bluetooth.sh;;

esac

