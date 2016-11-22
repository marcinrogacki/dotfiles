export EDYTOR=vim
export STEAM_FRAME_FORCE_CLOSE=1
export GOPATH=$HOME/workspace/go
export PATH=$PATH:$HOME/.slash/usr/bin:$GOPATH/bin
export URXVT_PERL_LIB=$HOME/.urxvt/ext/

# load bashrc on tmux session
case $- in *i*) . ~/.bashrc;; esac

if test -d ~/.slash/etc/profile.d/; then
	for profile in ~/.slash/etc/profile.d/*.sh; do
		test -r "$profile" && . "$profile"
	done
	unset profile
fi

# load not public stuff
if [ -f ~/.slash/home/bash_profile ]; then
    . ~/.slash/home/bash_profile
fi

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
fi
