#!/bin/sh

source $CONFIGITOR_BASE_DIR/.configitor/abstract.sh

link=`readlink ~/.vimrc`
vim_conf_file=`readlink -f $CONFIGITOR_BASE_DIR/vim/.vimrc`
if [ "$link" != "$vim_conf_file" ]; then
    c_error 'A config file .vimrc has not been properly linked.' 
fi
c_success 'A config file .vimrc is properly linked.' 
