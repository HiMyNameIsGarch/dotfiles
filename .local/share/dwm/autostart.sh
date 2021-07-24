#!/bin/sh

# Put wallpaper
feh --bg-scale --no-fehbg /home/himynameisgarch/Media/Wallpapers/Simple/Arch.png

# Start dwmblocks
dwmblocks >/dev/null & 

# Hide mouse when not needed
unclutter --jitter 50 --ignore-scrolling & 

# Map capslock to esc key
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'

# Start compositor picom
# picom --experimental-backends >/dev/null &

# Start redshift
killall redshift ; redshift >/dev/null &

# Start dunst 
dunst & 

# Output sound to speaker 
soundCard="HDA-Intel - HDA Intel PCH"
cardNum="$(grep "$soundCard" "/proc/asound/cards" | awk '{print $1}')"
amixer -c "$cardNum" sset "Auto-Mute Mode" 'Speaker Only' </dev/null


