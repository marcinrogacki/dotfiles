#!/bin/sh

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for dir in $script_dir/*/
do
  dir=${dir%*/}
  soft_dir=$script_dir/${dir##*/}
  if [ -f "$soft_dir/bashrc" ]; then
    . "$soft_dir/bashrc"
  fi
done
