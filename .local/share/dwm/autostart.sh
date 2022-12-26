#!/bin/sh

# Put wallpaper
feh --bg-scale --no-fehbg --recursive --randomize /home/garch/Media/Wallpapers/

# Start dwmblocks
dwmblocks >/dev/null &

# Hide mouse when not needed
unclutter --jitter 50 --ignore-scrolling &

# Map capslock to esc key
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'

# Start compositor picom
picom >/dev/null &

# Start redshift
redshift >/dev/null &

# Start dunst
dunst &

# Pulse audio
pulseaudio -D

# Programs
qbittorrent &
qutebrowser &

# Output sound to speaker
soundCard="HDA-Intel - HDA Intel PCH"
cardNum="$(awk "/$soundCard/ {print \$1}" /proc/asound/cards)"
amixer -c "$cardNum" sset "Auto-Mute Mode" 'Speaker Only' </dev/null

exit 0
