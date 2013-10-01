#!/bin/sh

source $HOME/.configitor/abstract.sh

source_file=$HOME/.configitor/configitor/hooks/post-merge
destination_file=$HOME/.git/hooks/post-merge

if [ ! -f $destination_file ]; then
    ln -s $source_file $destination_file
    c_success "<configitor> Added git post-merge hook (generates gitignore)".
else
    c_info "<configitor> Nothing to do."
fi
