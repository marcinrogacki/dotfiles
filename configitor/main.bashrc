#!/bin/sh

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
 
while read soft; do
    script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    soft_dir=$script_dir/../$soft
    if [ -f "$soft_dir/bashrc" ]; then
        . "$soft_dir/bashrc"
    fi
done < $script_dir/../.configitor/etc/order.sh
