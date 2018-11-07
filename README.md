About
=====

Dotofiles managed by GNU stow https://www.gnu.org/software/stow/

Install
=======

Use `stow.sh` script.

Terminology
===========
ENVIROMENT - A <user>@<host> directory which contains read set of dotfiles.

Structure
=========

dotfiles/common - A repository of configurations. Contains all available dotfiles. Not intended to install.
dotfiles/<user>@<host> - An ENVIROMENT. Contains a set of dotfiles for target user on specific host.
pacman.sh - A script to automatically install ENVIROMENT's package dependencies. Must be executed from
ENVIROMENT top directory. Ignored by stow (does not link it).
dep.pacman - A list of dependencies (pacman only) for certain dotfile directory. Ignored by stow (does not link it).

Dependencies
============

System dependency packages can be installed by using `sh pacman.sh`. Only Pacman
package manager is supported at the moment.
