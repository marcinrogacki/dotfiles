#!/bin/sh

if [ -d "$HOME"/.slash/etc/X11/xinit/xinitrc.d ] ; then
    for f in "$HOME"/.slash/etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi
