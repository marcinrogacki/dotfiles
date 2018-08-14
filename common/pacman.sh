#!/bin/sh

display_usage() {
cat << USAGE
Usage: sh `basename $0`

Searches recursively current directory for dep.pacman files and installs packages listed within them.
User must be granted to run pacman command.

COMMAND
    -h|--help       display this message
USAGE
}

for arg in "$@"; do
    if [ "$arg" = "-h" -o "$arg" = "--help" ]; then
        display_usage
        exit
    fi
done

pacman -S $(find -L . -name dep.pacman | xargs cat | sort -u)
