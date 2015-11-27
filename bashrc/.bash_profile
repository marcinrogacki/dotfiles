export EDYTOR=vim
export STEAM_FRAME_FORCE_CLOSE=1
export GOPATH=$HOME/workspace/go
export PATH=$PATH:$HOME/.slash/usr/bin:$GOPATH/bin

# load bashrc on tmux session
case $- in *i*) . ~/.bashrc;; esac

# load not public stuff
if [ -f ~/.slash/home/bash_profile ]; then
    . ~/.slash/home/bash_profile
fi
