#!/bin/sh

echo -e "\e[32mINSTALL STOW SOFTWARES FOR: COMMON\e[0m"
# xbindkeys: is a program that allows to bind commands to certain keys or key combinations on the keyboard (used by: tibia).
#   xdotool: simulate keyboard input and mouse activity, move and resize windows, etc (used by: tibia).
#   synergy: lets you easily share a single mouse and keyboard between multiple computers 
pacman -S xbindkeys xdotool synergy

if [ -f ./pacman-env.sh ]; then
    echo -e "\e[32mINSTALL STOW SOFTWARES FOR: ENV\e[0m"
    sh ./pacman-env.sh
fi
