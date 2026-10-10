# ---------------- Rofi Menu ---------------- >

kitty="$HOME/.config/rofi/icons/kitty.png"
brave="$HOME/.config/rofi/icons/brave.png"
discord="$HOME/.config/rofi/icons/discord.png"
spotify="$HOME/.config/rofi/icons/spotify.png"
code="$HOME/.config/rofi/icons/code.png"
idea="$HOME/.config/rofi/icons/idea.png"
rider="$HOME/.config/rofi/icons/rider.png"
godot="$HOME/.config/rofi/icons/godot.png"

option=$(

    # Add your favorites here, "Name\0icon\x1fPath_to_icon"

    printf " Kitty\0icon\x1f%s\n Brave\0icon\x1f%s\n Discord\0icon\x1f%s\n Spotify\0icon\x1f%s\n VS Code\0icon\x1f%s\n IntelliJ IDEA\0icon\x1f%s\n Jetbrains RIDER\0icon\x1f%s\n Godot\0icon\x1f%s" \
           "$kitty" "$brave" "$discord" "$spotify" "$code" "$idea" "$rider" "$godot" |

    rofi -dmenu -p "  " -show-icons -theme ~/.config/rofi/mocha.rasi

)

case "$option" in

    " Kitty")           kitty;;
    " Brave")           brave;;
    " Discord")         discord;;
    " Spotify")         spotify-launcher;;
    " VS Code")         code;;
    " IntelliJ IDEA")   idea;;
    " Jetbrains RIDER") rider;;
    " Godot")           godot-mono;;

esac

