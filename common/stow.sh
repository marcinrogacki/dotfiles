#!/bin/sh

git submodule update --init

stow -t ~ bashrc
stow -t ~ fluxbox
stow -t ~ git
stow -t ~ vim
stow -t ~ tmux
stow -t ~ X11
stow -t ~ games
stow -t ~ dunst
if [ -f ./.stow-env.sh ]; then
    sh ./.stow-env.sh
fi
