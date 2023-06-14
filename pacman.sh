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

# find -L "$env_dir" -name pacman.dep | xargs cat | grep -v '^#' | sort -u
# pacman -S --needed $(find -L "$env_dir" -name pacman.dep | xargs cat | grep -v '^#' | sort -u)

# for dep in `find -L "$env_dir" -name pacman.dep | xargs cat | grep -v '^#' | sort -u`; do
#     pacman -Rs "$dep"
# done

for dep_file in `find -L "$env_dir" -name pacman.dep`; do
                                  echo -e "\e[32m[FILE]\e[39m $dep_file"
    cat "$dep_file" | xargs -I {} echo -e "\e[32m[SOFT]\e[39m "{}
    pacman -S --noconfirm --needed $(cat "$dep_file" | grep -v '^#' | sort -u)
    # pacman -Rs $(cat "$dep_file" | xargs cat | grep -v '^#' | sort -u)
done
