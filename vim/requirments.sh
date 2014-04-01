#!/bin/sh
script_dir=$(cd `dirname $0` && pwd)
source $script_dir/../abstract.sh

source $script_dir/../ctags/bashrc
info=`ctags --version 2>/dev/null`
if ! echo $info | grep -q 'Compiled'; then
    c_error "Ctags not found"
fi
c_success "Ctags is working"

if [ ! -f "$script_dir/../python/bin/bin/python3-config" ]; then
    c_error "Python config is missing"
fi
c_success "Python config is accessible"
