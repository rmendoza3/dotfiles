#!/bin/bash
#xrandr --output VGA-0 --right-of DVI-0
#xrandr --output VGA-0 --primary
xsetroot -cursor_name left_ptr

# Turn numlock to on
numlockx &

# Start Chromium
exec google-chrome &

# Start Firefox
exec firefox &

# Start Thunderbird
exec thunderbird &

# Set alsa volume to 30%
amixer sset Master,0 40%

# Start Pianobar
#exec pianobar &

# Start MPD
mpd ~/.mpd/mpd.conf



# Use Xmonad Window Manager
/usr/bin/xmonad

# Use Scrotwm Window Manager
#/home/rmendoza/scrotwm/src/scrotwm-0.9.27/linux/scrotwm
