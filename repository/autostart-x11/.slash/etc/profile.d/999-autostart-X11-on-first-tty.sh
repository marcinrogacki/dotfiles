if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ]; then
  exec startx
fi
