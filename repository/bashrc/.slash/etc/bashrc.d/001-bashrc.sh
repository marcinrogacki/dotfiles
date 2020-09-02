# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# format and color prompt
if [ "$(id -u)" != "0" ]; then
    # user
    ps_user_color='00;32'
else
    # root
    ps_user_color='01;33'
fi
if [ -z "$SSH_CLIENT" ]; then
    # local
    ps_host_color='01;31'
else
    # ssh
    ps_host_color='0'
fi

PS1="\[\033[00;37m\]\t \[\033[${ps_user_color}m\]\u\[\033[${ps_host_color}m\]@\h \[\033[00;36m\]\w\[\033[00m\] \$ "

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias grep='grep --color=auto'
fi
