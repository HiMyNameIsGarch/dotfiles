#!/bin/sh

# Put wallpaper
feh --bg-scale --no-fehbg /home/himynameisgarch/Media/Wallpapers/coffeeBreak.png

# Start dwmblocks
dwmblocks >/dev/null & 

# Start compositor picom
# picom --experimental-backends >/dev/null &

# Start redshift
killall redshift ; redshift >/dev/null &

# Start dunst 
dunst & 

# Output sound to speaker 
soundCard="HDA-Intel - HDA Intel PCH"
cardNum="$(grep "$soundCard" "/proc/asound/cards" | awk '{print $1}')"
amixer -c $cardNum sset "Auto-Mute Mode" 'Speaker Only' </dev/null


