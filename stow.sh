#!/bin/sh

env="${1%/}"
shift
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
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
# "*/" means only directories
for dir in */; do
    case "$@" in
        *--revert*)
            stow -Dt ~ $dir
            ;;
        *)
            stow --ignore='dep.pacman' -t ~ $dir
            ;;
    esac
done
