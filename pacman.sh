#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

display_usage() {
cat << USAGE
Usage: sh `basename $0` DIRECTORY <COMMAND>

Searches recursively current directory for pacman.dep files and install
packages listed within them. User must be granted to run pacman command.


DIRECTORY
    Pick one from 'environment' directory.

COMMAND
    -h|--help   Display this message.

Example
    sh `basename $0` environment/mrogacki@homepc
    sh `basename $0` -h
USAGE
}

for arg in "$@"; do
    if [ "$arg" = "-h" -o "$arg" = "--help" ]; then
        display_usage
        exit
    fi
done

env="${1%/}"
env_dir="$SCRIPT_DIR/$env"
shift

if [[ "$env" != environment/* ]]; then
    >&2 echo "Wrong environment provided. Please provide one from 'environment' directory."
    exit 1
fi

if [ ! -d "$env_dir" ]; then
    >&2 echo "Not existing environment. Directory does not exists $env_dir"
    exit 1
fi

pacman -S --needed $(find -L . -name pacman.dep | xargs cat | grep -v '^#' | sort -u)
