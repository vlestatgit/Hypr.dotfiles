# ---------------- Rofi Bluetooth ---------------- >

#!/usr/bin/env bash

THEME="~/.config/rofi/mocha.rasi"

ICON_PAIRED=""
ICON_CONNECTED=""
ICON_UNKNOWN=""

bluetoothctl --timeout 3 scan on > /dev/null 2>&1 &

connected_macs=$(bluetoothctl devices Connected | awk '{print $2}')
paired_macs=$(bluetoothctl devices Paired | awk '{print $2}')

devices_list=$(bluetoothctl devices | awk -v paired_icon="$ICON_PAIRED" -v conn_icon="$ICON_CONNECTED" -v unkn_icon="$ICON_UNKNOWN" -v conn_list="$connected_macs" -v paired_list="$paired_macs" '{

    if ($0 ~ /Controller/ || $0 ~ /Discovering/ || $0 ~ /RSSI/ || $2 !~ /^([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}$/) {
        next
    }

    mac = $2
    
    name = $3
    for (i = 4; i <= NF; i++) {
        name = name " " $i
    }
    
    gsub(/^ +| +$/, "", name)
    
    if (name == "" || name == mac || name ~ /^([0-9A-Fa-f]{2}[:-]){5}[0-9A-Fa-f]{2}$/) {
        name = "Unknown"
    }
    
    if (index(conn_list, mac) > 0) {

        icon = conn_icon " "

    } else if (index(paired_list, mac) > 0) {

        icon = paired_icon "󰂯 "

    } else {

        icon = unkn_icon "󰂲 "

    }
    
    printf "%s %s  |  <span foreground=\"#6C7086\">%s</span>\n", icon, name, mac
}')

if [ -z "$devices_list" ]; then

    devices_list="No Devices Founded"

fi

chosen_option=$(echo -e "$devices_list" | rofi -dmenu -p "󰂯 " -i -lines 10 -width 30 -theme "$THEME" -markup-rows)

if [[ -z "$chosen_option" || "$chosen_option" == "No Devices Founded" ]]; then

    exit 1

fi

mac=$(echo "$chosen_option" | grep -oE '([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}')

if [ -n "$mac" ]; then

    if [[ "$chosen_option" =~ "$ICON_CONNECTED" ]]; then

        bluetoothctl disconnect "$mac" > /dev/null 2>&1

    else
        bluetoothctl pair "$mac" > /dev/null 2>&1
        bluetoothctl trust "$mac" > /dev/null 2>&1
        bluetoothctl connect "$mac" > /dev/null 2>&1

    fi
    
fi
