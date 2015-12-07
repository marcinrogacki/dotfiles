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
else
    killall -9 xbindkeys 2>/dev/null
    xbindkeys -f ~/.xbindkeysrc-tibia 2>/dev/null
    # set fluxbox style which will inform that keys are redefined
    xdotool key Alt+Shift+F2
fi
