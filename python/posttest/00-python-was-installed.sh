#!/bin/sh

source $CONFIGITOR_BASE_DIR/.configitor/abstract.sh

info=`$CONFIGITOR_BASE_DIR/python/bin/bin/python3 --version 2> /dev/null`
if ! echo $info | grep -q 'Python'; then
    c_error "Python hasn't been installed properly"
fi
c_success "Python has been installed"
