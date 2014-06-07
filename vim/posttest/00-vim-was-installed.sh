#!/bin/sh

source $CONFIGITOR_BASE_DIR/.configitor/abstract.sh

info=`$CONFIGITOR_BASE_DIR/vim/bin/bin/vim --version 2> /dev/null`
if ! echo $info | grep -q '+python'; then
    c_error "Vim hasn't been installed properly" 
fi
c_success 'Vim has been installed'
