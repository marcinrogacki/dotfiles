#!/bin/sh

unlink ~/.fluxbox/styles/dynamic
ln -s ~/.fluxbox/styles/tibia ~/.fluxbox/styles/dynamic
xdotool search --name "Tibia Linux" set_window --name "TibiaAnUniqueWindowNameWhichIsEasilyFoundByXdotool" 2>/dev/null

result=`ps aux | grep xbindkeysrc-tibia | grep -v grep`
if [ -n "$result" ]; then
    killall -9 xbindkeys 2>/dev/null
    xbindkeys -f ~/.xbindkeysrc 2>/dev/null
    # set previus fluxbox style
    xdotool key Alt+Shift+F1
    notify-send  "Tibia mode on" "CAPSLOCK to diable. Some keyboard keys like 'wasd' are unavailable!" --icon=dialog-information
else
    killall -9 xbindkeys 2>/dev/null
    xbindkeys -f ~/.xbindkeysrc-tibia 2>/dev/null
    # set fluxbox style which will inform that keys are redefined
    xdotool key Alt+Shift+F2
    notify-send  "Tibia mode off" "CAPSLOCK to enable. Keyboard keys back to normal" --icon=dialog-information
fi
