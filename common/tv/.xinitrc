xrdb -merge ~/.Xresources
setxkbmap pl
setxkbmap -option caps:none #disable capslock
# xbindkeys # keyboard binidings
# synergys -c ~/.synergy/synergy.conf # you can use one keyboard and mouse between pc/netbook over Internet
xrandr --output DVI-I-1 --auto  --output HDMI-0 --off
# xscreensaver -no-splash &
# pgrep redshift &> /dev/null || redshift -l 50.15:19.1 > /dev/null &
exec startfluxbox
