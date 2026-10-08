# ---------------- Rofi Wifi ---------------- >

#!/usr/bin/env bash

THEME="~/.config/rofi/mocha.rasi"

nmcli radio wifi on

wifi_list=$(nmcli --fields "SECURITY,SSID,BARS" device wifi list | sed 's/^IN-USE\s*//g' | sed 's/^  //g' | sort -u -k2,2 | awk -F'  +' '{
    if ($2 != "" && $2 != "SSID") {
    
        bars = $3
        
        if (bars ~ /====/ || bars ~ /▆█/)      { icon="󰤨  " } # Excelente
        else if (bars ~ /===_/ || bars ~ /▄▆/) { icon="󰤥  " } # Bom
        else if (bars ~ /==__/)                { icon="󰤢  " } # Razoável (versão clássica)
        else if (bars ~ /▂▄/)                  { icon="󰤢  " } # Razoável (versão blocos)
        else if (bars ~ /=___/ || bars ~ / ▂/) { icon="󰤟  " } # Fraco
        else                                   { icon="󰤯  " } # Muito fraco
        
        if ($1 ~ /WPA|WEP/) {
            printf "%s  %s [P]\n", icon, $2
        } else {
            printf "%s  %s\n", icon, $2
        }
    }
}')

chosen_network=$(echo -e "$wifi_list" | rofi -dmenu -p "󰤨  " -i -lines 10 -width 30 -theme "$THEME")

if [ -z "$chosen_network" ]; then
    exit 1
fi

ssid=$(echo "$chosen_network" | sed 's/^[^ ]*//g' | sed 's/ \[P\]//g' | xargs)

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
