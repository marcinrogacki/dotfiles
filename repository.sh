#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Remove trailing slash from arguments
repo_path="${1%/}"
env_path="${2%/}"

display_usage() {
cat << USAGE
Usage: sh `basename $0` REPO ENV

Link dotfiles from repository into given environment.
Main purpose of this script is to manages dependencies. Recursively links other
dotfiles which must be added into environment.

REPO
    One of subdirectory (config set) from repository directory.

ENV
    One from subdirectory from environment directory.

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

if [ -z "$repo_path" ]; then
    >&2 echo "Error: REPO arguments is required"
    exit 1
fi

if [ -z "$env_path" ]; then
    >&2 echo "Error: ENV arguments is required"
    exit 1
fi

repo_full_path="$SCRIPT_DIR/$repo_path"
if [ ! -d "$repo_full_path" ]; then
    >&2 echo "Error: REPO argument invalid. Directory does not exists $repo_full_path"
    exit 1
fi

env_full_path="$SCRIPT_DIR/$env_path"
if [ ! -d "$env_full_path" ]; then
    >&2 echo "Error: ENV argument invalid. Directory does not exists $env_full_path"
    exit 1
fi

# Prevent using the root repository directory
if [ "$repo_full_path" = "$SCRIPT_DIR/repository" ]; then
    >&2 echo "Error: REPO argument invalid. Need to provide a subdirectory from repository/"
    exit 1
fi

# Prevent using the root environment directory
if [ "$env_full_path" = "$SCRIPT_DIR/environment" ]; then
    >&2 echo "Error: ENV argument invalid. Need to provide a subdirectory from environment/"
    exit 1
fi

link_repository() {
    arg_repo_path="$1"
    arg_env_path="$2"
    arg_prefix="$3"
    arg_repo_full_path="$SCRIPT_DIR/$arg_repo_path"
    arg_env_full_path="$SCRIPT_DIR/$arg_env_path"
    # easier than check if already exists with same link
    unlink "$arg_env_full_path/`basename $arg_repo_path`" 2>/dev/null
    echo "${arg_prefix}Install `basename $arg_repo_path` in `basename $arg_env_path`"
    ln -s ../../"$arg_repo_path" $arg_env_path


    # cd "$env_dir";
    # easier than check if already exists with same link
    # dotfile=`basename "$repository"`
    # unlink "$dotfile" 2>/dev/null
    # echo "Install $dotfile in $env_dir"
    # ln -s ../../"$repository"

    dependency_repo_path=$arg_repo_path/dotfiles.dep
    dependency_repo_full_path="$SCRIPT_DIR/$dependency_repo_path"
    if [ ! -f "$dependency_repo_full_path" ]; then
        exit 0;
    fi

    for dependency_repo_name in `cat "$dependency_repo_full_path"`; do
        dependency_repo_path="repository/$dependency_repo_name"
        dependency_repo_full_path="$SCRIPT_DIR/$dependency_repo_path"
        if [ -d "$dependency_repo_full_path" ]; then
            link_repository "$dependency_repo_path" "$arg_env_path" "$arg_prefix  "
        else
            >&2 echo "Not existing dependency repository. Directory does not exists: $dependency_repo_full_path. Dependency file: $dependency_repo_path"
        fi
    done
}

link_repository "$repo_path" "$env_path"
