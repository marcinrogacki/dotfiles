#!/bin/bash

_notifysnd() {
    local notifysnd cur
    cur="${COMP_WORDS[COMP_CWORD]}"
    argc=$COMP_CWORD
    if [ "$argc" == "1" ]; then
        compreply_args=`ls "$HOME/.slash/var/notifysnd"`
        COMPREPLY=( $(compgen -W "${compreply_args}" -- ${cur}) )
    fi
    return 0
}

complete -F _notifysnd notifysnd
