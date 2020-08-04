#!/bin/sh

if [ -d "$HOME"/.slash/etc/Xresources.d ] ; then
    for f in "$HOME"/.slash/etc/Xresources.d/?* ; do
        xrdb -merge "$f"
    done
    unset f
fi

if [ -d "$HOME"/.slash/etc/xinitrc.d ] ; then
    for f in "$HOME"/.slash/etc/xinitrc.d/?*.sh ; do
        . "$f"
    done
    unset f
fi
