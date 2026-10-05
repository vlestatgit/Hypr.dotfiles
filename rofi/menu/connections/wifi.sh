# ---------------- Rofi Wifi ---------------- >

wifi_status=$(nmcli radio wifi)

if [ "$wifi_status" = "disabled" ]; then

    formatted_list=""

else

    wifi_list=$(nmcli -f "SSID,SIGNAL" device wifi list | tail -n +2 | grep -v '^--' | sort -t':' -k1,1 -k2,2nr | sort -u -k1,1)

    formatted_list=""

    while read -r line; do

        [ -z "$line" ] && continue
        
        ssid=$(echo "$line" | sed 's/[0-9]*$//' | sed 's/[[:space:]]*$//')
        signal=$(echo "$line" | awk '{print $NF}')
        
        if   [ "$signal" -ge 80 ]; then icon="󰤨  "

        elif [ "$signal" -ge 60 ]; then icon="󰤥  "
        elif [ "$signal" -ge 40 ]; then icon="󰤢  "
        elif [ "$signal" -ge 20 ]; then icon="󰤟  "

        else icon="󰤯  "

        fi

        if [ -n "$ssid" ]; then

            formatted_list="${formatted_list}${icon}  ${ssid}\n"

        fi

    done <<< "$wifi_list"

fi

if [ "$wifi_status" = "disabled" ]; then

    chosen_wifi=$(echo -e "$formatted_list" | rofi -dmenu -i -p "  " -theme ~/.config/rofi/mocha.rasi -theme-str 'entry { placeholder: "Disabled"; }')

else

    chosen_wifi=$(echo -e "$formatted_list" | rofi -dmenu -i -p "󰤨  " -theme ~/.config/rofi/mocha.rasi -theme-str 'entry { placeholder: "Search"; }')

fi

[ -z "$chosen_wifi" ] && exit 0

ssid_name=$(echo "$chosen_wifi" | sed 's/^[          ]  //')

is_saved=$(nmcli -g NAME connection show | grep -x "$ssid_name")

if [ -n "$is_saved" ]; then

    notify-send "Wi-Fi" "Conectando a $ssid_name..."
    nmcli device wifi connect "$ssid_name"

else

    wifi_password=$(
        
        rofi -dmenu \
        -p " " \
        -password \
        -theme ~/.config/rofi/mocha.rasi -theme-str 'window {width: 25%;} listview {lines: 0;} inputbar {children: [prompt, entry];} entry { placeholder: "Enter Pass"; }'
        
    )

    if [ -n "$wifi_password" ]; then

        notify-send "Wi-Fi" "Conectando a $ssid_name..."
        nmcli device wifi connect "$ssid_name" password "$wifi_password"

    fi
    
fi
