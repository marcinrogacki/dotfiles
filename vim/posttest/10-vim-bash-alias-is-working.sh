#!/bin/sh

source $CONFIGITOR_BASE_DIR/.configitor/abstract.sh

source $CONFIGITOR_BASE_DIR/vim/bashrc
info=`alias vim 2>/dev/null`
if ! echo $info | grep -q '/bin/bin/vim'; then
    c_error "Alias for 'vim' command hasn't been added."
fi
c_success 'Alias for 'vim' command is working' 
