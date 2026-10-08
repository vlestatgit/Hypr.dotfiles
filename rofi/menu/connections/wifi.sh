# ---------------- Rofi Wifi ---------------- >

#!/usr/bin/env bash

# Caminho para o seu tema customizado
THEME="~/.config/rofi/mocha.rasi"

# 1. Garante que o Wi-Fi está ligado
nmcli radio wifi on

# OTIMIZAÇÃO: Dispara a atualização de redes em segundo plano (Assíncrono)
# Isso faz o menu abrir instantaneamente sem travar a tela esperando o sinal estabilizar
nmcli device wifi rescan > /dev/null 2>&1 &

# 2. Captura a lista de redes tratando os blocos de espaços dinâmicos corretamente
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
            printf "%s%s [P]\n", icon, $2
        } else {
            printf "%s%s\n", icon, $2
        }
    }
}')

# 3. Abre o menu principal do Rofi (Abertura imediata)
chosen_network=$(echo -e "$wifi_list" | rofi -dmenu -p "󰤨  " -i -lines 10 -width 30 -theme "$THEME")

# Se o usuário fechar o Rofi sem escolher nada, encerra o script
if [ -z "$chosen_network" ]; then
    exit 1
fi

# 4. Extrai apenas o nome da rede (SSID) limpando o ícone, a flag [P] e espaços extras
ssid=$(echo "$chosen_network" | sed 's/^[^ ]*//g' | sed 's/\[P\]//g' | xargs)

# 5. Verifica se a rede precisa de senha usando a flag [P]
if [[ "$chosen_network" =~ "[P]" ]]; then

    # Abre o rofi compacto com seu tema, prompt de cadeado e placeholder personalizado
    password=$(rofi -dmenu \
        -p " " \
        -password \
        -lines 0 \
        -theme "$THEME" \
        -theme-str 'listview {enabled: false;} window {width: 400px;} entry {placeholder: "Enter Pass";}')
    
    # Se cancelou a senha, aborta
    if [ -z "$password" ]; then
        exit 1
    fi
    
    # Tenta conectar com a senha fornecida
    nmcli device wifi connect "$ssid" password "$password"

else
    # Conecta em redes abertas
    nmcli device wifi connect "$ssid"
fi
