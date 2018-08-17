#!/bin/sh

env=${PWD##*/}
case "$env" in
    *@*)
        ## All correct, we can procceed.
        ;;
    *)
        >&2 echo "$env - not a env! Are you in stow directory? Must be properly named with domain separator <user>@<domain>."
        exit 1
        ;;
esac

for dir in */; do
    case "$@" in
        *--revert*)
            stow -Dt ~ $dir
            ;;
        *)
            stow --ignore='dep.pacman' -t ~ $dir
            ;;
    esac
done
