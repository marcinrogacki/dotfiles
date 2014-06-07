#!/bin/sh

source $CONFIGITOR_BASE_DIR/.configitor/abstract.sh
soft_dir=$CONFIGITOR_BASE_DIR/ctags

info=`$soft_dir/bin/bin/ctags --version 2> /dev/null`

if ! echo $info | grep -q 'Compiled'; then
    c_error "Ctags hasn't been installed properly"
fi

c_success "Ctags has been installed"


