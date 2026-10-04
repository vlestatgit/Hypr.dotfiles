# ---------------- Waybar Auto Reload ----------------

while inotifywait -e close_write ~/.config/waybar; do killall -SIGUSR2 waybar; done

# Use this before making changes to the "config.jsonc" for live changes at waybar

