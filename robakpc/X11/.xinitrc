xrdb -merge ~/.Xresources
setxkbmap pl
setxkbmap -option caps:none #disable capslock
xbindkeys # keyboard binidings
synergys -c ~/.synergy/synergy.conf # you can use one keyboard and mouse between pc/netbook over Internet
xscreensaver -no-splash &
exec startfluxbox
