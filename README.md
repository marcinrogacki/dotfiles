About
=====

Dotofiles managed by GNU stow.

Install
=======

GNU Stow is a *symlink farm manager which takes distinct packages of software
and/or data located in separate directories on the filesystem, and makes them
appear to be installed in the same place.*


Usually launch `stow.sh` which will install dotfiles.

Requirments
===========

#### pc
- bash
    * tmux
- tmux
    * xclip
    * ssh

#### netbook
- bash
    * tmux
- tmux
    * xclip
    * ssh
- fluxbox
    * cbatticon

Description
===========

### bash
Handles user startup scripts and behaviours
* .slash/etc/profile.d - same purpose like /etc/profile.d

### tmux
* Smart search (+ highlight): https://github.com/tmux-plugins/tmux-copycat#search
* Open file/url utility: https://github.com/tmux-plugins/tmux-open#examples
* Copy clipboard: https://github.com/tmux-plugins/tmux-yank
* [command] tmux-ssh - get's server from tmux session name and try connect using ssh
