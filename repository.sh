#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

display_usage() {
cat << USAGE
Usage: sh `basename $0` DOTFILE ENVIRONMENT

Link dotfiles from repository into given environment.
Main purpose of this script is to manages dependencies. Recursively links other
dotfiles which must be added into environment.

DOTFILE
    One from repository directory.

ENVIRONMENT
    One from environment directory.

COMMAND
    -h|--help   Display this message.

Example
    sh `basename $0` repository/bashrc environment/mrogacki@homepc
    sh `basename $0` -h
USAGE
}

for arg in "$@"; do
    if [ "$arg" = "-h" -o "$arg" = "--help" ]; then
        display_usage
        exit
    fi
done

dotfile="${1%/}"
dotfile_dir="$SCRIPT_DIR/$dotfile"

if [[ "$dotfile" != repository/* ]]; then
    >&2 echo "Wrong dotfile provided. Please provide one from 'repository' directory."
    exit 1
fi

if [ ! -d "$dotfile_dir" ]; then
    >&2 echo "Not existing dotfile. Directory does not exists $dotfile_dir"
    exit 1
fi

env="${2%/}"
env_dir="$SCRIPT_DIR/$env"

if [[ "$env" != environment/* ]]; then
    >&2 echo "Wrong environment provided. Please provide one from 'environment' directory."
    exit 1
fi

if [ ! -d "$env_dir" ]; then
    >&2 echo "Not existing environment. Directory does not exists $env_dir"
    exit 1
fi

cd "$env_dir";
ln -s ../../$dotfile
