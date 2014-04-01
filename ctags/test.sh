#!/bin/sh

script_dir=$(cd `dirname $0` && pwd)
source $script_dir/../abstract.sh

info=`$script_dir/bin/bin/ctags --version 2> /dev/null`

if ! echo $info | grep -q 'Compiled'; then
    c_error "Software hasn't been installed properly"
fi

c_success "Software has been installed"

source $script_dir/bashrc

info=`ctags --version 2> /dev/null`

if ! echo $info | grep -q 'Compiled'; then
    c_error "Alias hasn't been added"
fi

c_success "Alias is working"
