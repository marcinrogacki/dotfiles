export EDYTOR=vim

# load bashrc on tmux session
case $- in *i*) . ~/.bashrc;; esac

# load not public stuff
if [ -f ~/.private/bashrc/bash_profile ]; then
    . ~/.private/bashrc/bash_profile
fi
