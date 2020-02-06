if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ]; then
  startx
fi
