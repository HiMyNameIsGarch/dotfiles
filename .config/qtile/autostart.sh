#!/bin/bash

# Put wallpaper
feh --bg-scale ~/Media/Wallpapers/space.jpg

# Output sound to speakers
amixer -c 1 sset "Auto-Mute Mode" Disabled

# Start compozitor picom
picom --experimental-backends
