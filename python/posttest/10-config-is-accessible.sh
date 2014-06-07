#!/bin/sh

source $CONFIGITOR_BASE_DIR/.configitor/abstract.sh

if [ ! -d "$CONFIGITOR_BASE_DIR/python/bin/lib/python3.4/config-3.4m" ]; then
    c_error "Python config directory is missing"
fi
c_success "Python config is accessible"
