#!/bin/sh

if [ -d "$HOME"/.slash/etc/X11/xinit/Xresources.d ] ; then
    for f in "$HOME"/.slash/etc/X11/xinit/Xresources.d/?* ; do
        xrdb -merge "$f"
    done
    unset f
fi

if [ -d "$HOME"/.slash/etc/X11/xinit/xinitrc.d ] ; then
    for f in "$HOME"/.slash/etc/X11/xinit/xinitrc.d/?*.sh ; do
        . "$f"
    done
    unset f
fi
