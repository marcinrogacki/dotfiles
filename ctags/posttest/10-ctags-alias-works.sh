#!/bin/sh

source $CONFIGITOR_BASE_DIR/.configitor/abstract.sh
soft_dir=$CONFIGITOR_BASE_DIR/ctags

. $soft_dir/bashrc

info=`ctags --version 2> /dev/null`

if ! echo $info | grep -q 'Compiled'; then
    c_error "Ctags alias hasn't been added"
fi

c_success "Ctags alias works"
