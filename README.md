# About

Dotofiles managed by GNU stow https://www.gnu.org/software/stow/

# USAGE

* stow.sh       - install dotfiles from given environment.
* pacman.sh     - install system packages needed for given environment.
* repository.sh - link dotfile into repository along with handling dependencies
                  to other dotfiles

# Structure

* repository  - A repository of dotfiles. Contains all available configuratins.
                Intended to be used as link in environment directory.
* environment - Contains a set of dotfiles for target user on specific host.
* pacman.dep  - A list of sytem dependencies for certain dotfile (installed by
                pacman).

# Ignored files

Those files will be not considered as dotfile and not linked to home directory.

* README.md
* \*.dep
