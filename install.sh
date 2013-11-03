#!/bin/sh

#find ./* -maxdepth 0 -type d

for dir in ./*/
do
  dir=${dir%*/}
  soft_dir=${dir##*/}
  if [ -f "$soft_dir/bashrc" ]; then
    cat "$soft_dir/bashrc"
  fi
done
