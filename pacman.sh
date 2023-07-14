#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

display_usage() {
cat << USAGE
Usage: sh `basename $0` USER <COMMAND>

Install system dependencies. Install listed packages from pacman.dep files in
environment directory. Must be executed as root user.

USER
    System user name from environment directory.

COMMAND
    -h|--help   Display this message.

Example
    sh `basename $0 robak`
    sh `basename $0` -h
USAGE
}

for arg in "$@"; do
    if [ "$arg" = "-h" -o "$arg" = "--help" ]; then
        display_usage
        exit
    fi
done

user="$1"
env_dir="$SCRIPT_DIR/environment/$USER@$HOSTNAME"
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
