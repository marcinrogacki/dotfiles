About
=====

Dotofiles managed by GNU stow.

Install
=======

GNU Stow is a *symlink farm manager which takes distinct packages of software
and/or data located in separate directories on the filesystem, and makes them
appear to be installed in the same place.*

So, when dotfiles are in `~/dotfiles`, use

```
stow bashrc
stow fluxbox
stow vim
# etc
```

When destination of `dotfiles` is different than home direcotry, then

```
stow -t ~ bashrc
stow -t ~ fluxbox
stow -t ~ vim
# etc
```

A `install.stow.sh` is a simple script to install all at once.
