#!/bin/sh

# Put wallpaper
feh --bg-scale --no-fehbg /home/himynameisgarch/Media/Wallpapers/Doom/Doom-Eternal_Maurader_Wallpaper_1920x1080-01.jpg &

# Start dwmblocks
dwmblocks >/dev/null & 

# Start compositor picom
picom --experimental-backends >/dev/null &

# Start redshift
redshift >/dev/null &

# Start dunst 
dunst & 

# Output sound to speaker 
soundCard="HDA-Intel - HDA Intel PCH"
cardNum="$(cat /proc/asound/cards | grep $soundCard | awk '{print $1}')"
amixer -c $cardNum sset "Auto-Mute Mode" 'Speaker Only' </dev/null


