#!/usr/bin/env bash

THEME="~/.config/rofi/mocha.rasi"

nmcli radio wifi on

nmcli device wifi rescan > /dev/null 2>&1 &

wifi_list=$(nmcli --fields "SECURITY,SSID,SIGNAL" device wifi list | sed 's/^IN-USE\s*//g' | sed 's/^  //g' | sort -u -k2,2 | awk -F'  +' '{

    if ($2 != "" && $2 != "SSID") {
        
        signal = $3 + 0
        
        if (signal >= 75)       { icon="󰤨  " } # Excelente
        else if (signal >= 50)  { icon="󰤥  " } # Bom
        else if (signal >= 25)  { icon="󰤢  " } # Razoável
        else if (signal > 0)    { icon="󰤟  " } # Fraco
        else                    { icon="󰤯  " } # Sem sinal
        
        if ($1 ~ /WPA|WEP/) {

            printf "%s%s [P]\n", icon, $2

        } else {

            printf "%s%s\n", icon, $2

        }
    }
}')

chosen_network=$(echo -e "$wifi_list" | rofi -dmenu -p "󰤨  " -i -lines 10 -width 30 -theme "$THEME")

if [ -z "$chosen_network" ]; then

    exit 1

fi

ssid=$(echo "$chosen_network" | sed 's/^[^ ]*  //g' | sed 's/ \[P\]//g' | xargs)

if [[ "$chosen_network" =~ "[P]" ]]; then

    password=$(rofi -dmenu \
        -p " " \
        -password \
        -lines 0 \
        -theme "$THEME" \
        -theme-str 'listview {enabled: false;} window {width: 400px;} entry {placeholder: "Enter Pass";}')
    
    if [ -z "$password" ]; then

        exit 1

    fi
    
    nmcli device wifi connect "$ssid" password "$password"

else

    nmcli device wifi connect "$ssid"

fi
