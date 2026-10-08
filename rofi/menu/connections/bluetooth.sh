# ---------------- Rofi Bluetooth ---------------- >

#!/usr/bin/env bash

# Caminho para o seu tema customizado
THEME="~/.config/rofi/mocha.rasi"

# --- DEFINA OS SEUS ÍCONES AQUI ---
ICON_PAIRED="  "        # Dispositivo Emparelhado (Mas não conectado)
ICON_CONNECTED="  "     # Dispositivo Conectado atualmente
ICON_UNKNOWN="  "       # Dispositivo Desconhecido (Encontrado no scan recente)
# ----------------------------------

# 1. DISPARA O SCAN EM SEGUNDO PLANO (Otimização de Velocidade)
# O caractere '&' faz o bluetoothctl rodar de forma invisível, abrindo o Rofi na hora.
bluetoothctl --timeout 3 scan on > /dev/null 2>&1 &

# 2. Captura os estados de conexão e emparelhamento de forma imediata
connected_macs=$(bluetoothctl devices Connected | awk '{print $2}')
paired_macs=$(bluetoothctl devices Paired | awk '{print $2}')

# 3. Captura os dispositivos conhecidos e categoriza usando as listas de estado
devices_list=$(bluetoothctl devices | awk -v paired_icon="$ICON_PAIRED" -v conn_icon="$ICON_CONNECTED" -v unkn_icon="$ICON_UNKNOWN" -v conn_list="$connected_macs" -v paired_list="$paired_macs" '{
    # IGNORA LINHAS DE SISTEMA
    if ($0 ~ /Controller/ || $0 ~ /Discovering/ || $0 ~ /RSSI/ || $2 !~ /^([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}$/) {
        next
    }

    mac = $2
    
    # Reconstrói o nome amigável iniciando do terceiro parâmetro da linha
    name = $3
    for (i = 4; i <= NF; i++) {
        name = name " " $i
    }
    
    # Remove espaços vazios nas bordas do nome
    gsub(/^ +| +$/, "", name)
    
    # Se o nome for o próprio MAC ou estiver vazio
    if (name == "" || name == mac || name ~ /^([0-9A-Fa-f]{2}[:-]){5}[0-9A-Fa-f]{2}$/) {
        name = "Unknown"
    }
    
    # ATRIBUIÇÃO DOS ÍCONES:
    if (index(conn_list, mac) > 0) {
        icon = conn_icon " "   # Ativo e Conectado
    } else if (index(paired_list, mac) > 0) {
        icon = paired_icon "󰂯 " # Emparelhado/Salvo no PC
    } else {
        icon = unkn_icon "󰂲 "   # Novo aparelho achado no ar
    }
    
    # Formata a linha usando tags Pango para colorir o ID com #6C7086
    printf "%s %s  |  <span foreground=\"#6C7086\">%s</span>\n", icon, name, mac
}')

# Se nenhum aparelho for listado, evita que o menu abra totalmente em branco
if [ -z "$devices_list" ]; then
    devices_list="No Devices Founded"
fi

# 4. Abre o menu do Rofi (Abertura instantânea agora)
chosen_option=$(echo -e "$devices_list" | rofi -dmenu -p "󰂯 " -i -lines 10 -width 30 -theme "$THEME" -markup-rows)

# Se o usuário fechar o Rofi sem escolher nada, encerra o script
if [[ -z "$chosen_option" || "$chosen_option" == "No Devices Founded" ]]; then
    exit 1
fi

# 5. Extrai o MAC Address limpando as tags Pango para realizar a conexão
mac=$(echo "$chosen_option" | grep -oE '([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}')

if [ -n "$mac" ]; then
    # Se o ícone atual for de conectado, executa a desconexão. Do contrário, conecta.
    if [[ "$chosen_option" =~ "$ICON_CONNECTED" ]]; then
        bluetoothctl disconnect "$mac" > /dev/null 2>&1
    else
        bluetoothctl pair "$mac" > /dev/null 2>&1
        bluetoothctl trust "$mac" > /dev/null 2>&1
        bluetoothctl connect "$mac" > /dev/null 2>&1
    fi
fi
