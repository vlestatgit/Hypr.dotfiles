# ---------------- Rofi Menu ---------------- >

brave="$HOME/.config/rofi/icons/brave.png"
discord="$HOME/.config/rofi/icons/discord.png"
spotify="$HOME/.config/rofi/icons/spotify.png"
code="$HOME/.config/rofi/icons/code.png"
idea="$HOME/.config/rofi/icons/idea.png"
rider="$HOME/.config/rofi/icons/rider.png"

option=$(

    # Add your favorites here, "Name\0icon\x1fPath_to_icon"

    printf " Brave\0icon\x1f%s\n Discord\0icon\x1f%s\n Spotify\0icon\x1f%s\n VS Code\0icon\x1f%s\n IntelliJ IDEA\0icon\x1f%s\n Jetbrains RIDER\0icon\x1f%s" \
           "$brave" "$discord" "$spotify" "$code" "$idea" "$rider" |

    rofi -dmenu -p "  " -show-icons -theme ~/.config/rofi/mocha.rasi

)

case "$option" in

    " Brave")           brave;;
    " Discord")         discord;;
    " Spotify")         spotify-launcher;;
    " VS Code")         code;;
    " IntelliJ IDEA")   idea;;
    " Jetbrains RIDER") rider;;

esac

