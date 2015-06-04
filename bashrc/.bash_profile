export EDYTOR=vim
export STEAM_FRAME_FORCE_CLOSE=1

# load bashrc on tmux session
case $- in *i*) . ~/.bashrc;; esac

# load not public stuff
if [ -f ~/.private/bashrc/bash_profile ]; then
    . ~/.private/bashrc/bash_profile
fi
