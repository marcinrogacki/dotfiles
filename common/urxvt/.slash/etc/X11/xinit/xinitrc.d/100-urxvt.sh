urxvtresources="$HOME"/.urxvt/Xresources
if [ -f "$urxvtresources" ]; then
    xrdb -merge "$urxvtresources"
fi
