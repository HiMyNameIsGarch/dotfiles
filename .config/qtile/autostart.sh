#!/bin/bash

# Put wallpaper
feh --bg-scale ~/Media/Wallpapers/space.jpg

# Output sound to speakers
soundCard="HDA-Intel - HDA Intel PCH"
cardNum="$(cat /proc/asound/cards | grep "$soundCard" | cut -d' ' -f2)"
amixer -c $cardNum sset "Auto-Mute Mode" 'Speaker Only' > /dev/null

# Start compozitor picom
picom --experimental-backends &

# Start redshift
redshift &
