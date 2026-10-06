# ---------------- Rofi Bluetooth ---------------- >

bt_status=$(bluetoothctl show | grep "Powered: yes")

if [ -z "$bt_status" ]; then

    formatted_list=""

else

    bluetoothctl --timeout 2 scan on > /dev/null 2>&1 &

    sleep 1

    bt_list=$(bluetoothctl devices | awk '{print $2}')

    formatted_list=""
    is_any_connected=""

    while read -r mac; do

        [ -z "$mac" ] && continue
        
        name=$(bluetoothctl info "$mac" | grep "Name:" | sed 's/^[[:space:]]*Name:[[:space:]]*//')
        
        is_connected=$(bluetoothctl info "$mac" | grep "Connected: yes")
        is_paired=$(bluetoothctl info "$mac" | grep "Paired: yes")
        
        if [ -n "$is_connected" ]; then

            icon=" "
            is_any_connected="yes"

        elif [ -n "$is_paired" ]; then 

            icon="󰂯 "

        else 

            icon="󰂲 "

        fi

        if [ -n "$name" ]; then

            formatted_list="${formatted_list}${icon}  ${name} <span foreground='#6C7086'>(${mac})</span>\n"

        fi

    done <<< "$bt_list"

fi

if [ -z "$bt_status" ]; then

    chosen_device=$(echo -e "$formatted_list" | rofi -dmenu -i -markup-rows -p "󰂲 " -theme ~/.config/rofi/mocha.rasi -theme-str 'entry { placeholder: "Disabled"; }')

elif [ -z "$formatted_list" ]; then

    chosen_device=$(echo -e "$formatted_list" | rofi -dmenu -i -markup-rows -p "󰂯 " -theme ~/.config/rofi/mocha.rasi -theme-str 'entry { placeholder: "No devices founded"; }')

elif [ -n "$is_any_connected" ]; then

    chosen_device=$(echo -e "$formatted_list" | rofi -dmenu -i -markup-rows -p " " -theme ~/.config/rofi/mocha.rasi -theme-str 'entry { placeholder: "Search"; }')

else

    chosen_device=$(echo -e "$formatted_list" | rofi -dmenu -i -markup-rows -p "󰂯 " -theme ~/.config/rofi/mocha.rasi -theme-str 'entry { placeholder: "Search"; }')

fi

[ -z "$chosen_device" ] && exit 0

mac_address=$(echo "$chosen_device" | awk -F'(' '{print $2}' | tr -d ')' | sed 's/<[^>]*>//g')

check_paired=$(bluetoothctl info "$mac_address" | grep "Paired: yes")
check_connect=$(bluetoothctl info "$mac_address" | grep "Connected: yes")

if [ -z "$check_paired" ]; then
    
    notify-send "Bluetooth" "Pareando com novo dispositivo..."
    bluetoothctl pair "$mac_address" && bluetoothctl trust "$mac_address" && bluetoothctl connect "$mac_address"

elif [ -n "$check_connect" ]; then

    notify-send "Bluetooth" "Desconectando de dispositivo..."
    bluetoothctl disconnect "$mac_address"

else

    notify-send "Bluetooth" "Conectando ao dispositivo..."
    bluetoothctl connect "$mac_address"
    
fi