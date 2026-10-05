# ---------------- Rofi Menu ---------------- >

kitty="$HOME/.config/rofi/icons/kitty.png"
brave="$HOME/.config/rofi/icons/brave.png"
steam="$HOME/.config/rofi/icons/steam.png"
code="$HOME/.config/rofi/icons/code.png"
idea="$HOME/.config/rofi/icons/idea.png"
minecraft="$HOME/.config/rofi/icons/minecraft.png"

option=$(

    # Add your favorites here, "Name\0icon\x1fPath_to_icon"

    printf " Kitty\0icon\x1f%s\n Brave\0icon\x1f%s\n Steam\0icon\x1f%s\n VS Code\0icon\x1f%s\n IntelliJ IDEA\0icon\x1f%s\n Minecraft XMCL\0icon\x1f%s" \
           "$kitty" "$brave" "$steam" "$code" "$idea" "$minecraft" |

    rofi -dmenu -p "" -show-icons -theme ~/.config/rofi/mocha.rasi

)

case "$option" in

    " Kitty")          kitty;;
    " Brave")          brave;;
    " Steam")          steam;;
    " VS Code")        code;;
    " IntelliJ IDEA")  idea;;
    " Minecraft XMCL") xmcl;;

esac

