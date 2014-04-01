#!/bin/sh

script_dir=$(cd `dirname $0` && pwd)
source $script_dir/../abstract.sh

info=`$script_dir/bin/bin/python3 --version 2> /dev/null`

if ! echo $info | grep -q 'Python'; then
    c_error "Software hasn't been installed properly"
fi

c_success "Software has been installed"
