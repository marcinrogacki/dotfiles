#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

display_usage() {
cat << USAGE
Usage: sh `basename $0` ENVIRONMENT DOTFILES

Link dotfiles from repository into given environment.
Main purpose of this script is to manages dependencies. Recursively links other
dotfiles which must be added into environment.

DOTFILES
    One from repository directory.

ENVIRONMENT
    One from environment directory.

COMMAND
    -h|--help   Display this message.

Example
    sh `basename $0` environment/mrogacki@homepc repository/bashrc
    sh `basename $0` -h
USAGE
}

link_repository() {
    env_dir="$1"
    repository="$2"
    cd "$env_dir";
    # easier than check if already exists with same link
    dotfile=`basename "$repository"`
    unlink "$dotfile" 2>/dev/null
    ln -s ../../"$repository"

    dependency_file=../../"$repository"/dotfiles.dep
    if [ ! -f "$dependency_file" ]; then
        exit 0;
    fi

    for dependency_dotfile in `cat "$dependency_file"`; do
        if [ ! -d "$dependency_dotfile" ]; then
            echo "installing dependency: $dotfile needs $dependency_dotfile"
            link_repository "$env_dir" "repository/$dependency_dotfile"
        fi
    done
}

for arg in "$@"; do
    if [ "$arg" = "-h" -o "$arg" = "--help" ]; then
        display_usage
        exit
    fi
done

env="${1%/}"
if [[ "$env" != environment/* ]]; then
    >&2 echo "Wrong environment provided. Please provide one from 'environment' directory."
    exit 1
fi

env_dir="$SCRIPT_DIR/$env"
if [ ! -d "$env_dir" ]; then
    >&2 echo "Not existing environment. Directory does not exists $env_dir"
    exit 1
fi

repository="${2%/}"
if [[ "$repository" != repository/* ]]; then
    >&2 echo "Wrong repository provided. Please provide one from 'repository' directory."
    exit 1
fi

repository_dir="$SCRIPT_DIR/$repository"
if [ ! -d "$repository_dir" ]; then
    >&2 echo "Not existing repository. Directory does not exists $repository_dir"
    exit 1
fi

link_repository "$env_dir" "$repository"
