#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

display_usage() {
cat << USAGE
Usage: sh `basename $0` <COMMAND>

Apply dotfiles. Automatically picks files from environment/<user>@<host> directory.

COMMAND
    -h|--help   Display this message.
    --revert    Undo applied dotfiles.

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

env_dir="$SCRIPT_DIR/environment/$USER@$HOSTNAME"
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
            stow --ignore='.*.dep' -t ~ $dir
            ;;
    esac
done
