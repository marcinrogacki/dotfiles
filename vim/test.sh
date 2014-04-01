#!/bin/sh

script_dir=$(cd `dirname $0` && pwd)
source $script_dir/../abstract.sh

info=`$script_dir/bin/bin/vim --version 2> /dev/null`

if ! echo $info | grep -q '+python'; then
    c_error "Software hasn't been installed properly"
fi

c_success "Software has been installed"

source $script_dir/bashrc

info=`vim --version 2> /dev/null`

if ! echo $info | grep -q '+python'; then
    c_error "Alias hasn't been added"
fi

c_success "Alias is working"

link=`readlink ~/.vimrc`
if [ "$link" != "$script_dir/.vimrc" ]; then
    c_error 'A .vimrc link has filed.'
fi
c_success 'A .vimrc link exists.'

link=`readlink ~/.vim`
if [ $link != $script_dir/.vim ]; then
    c_error 'A .vim link has filed.'
fi
c_success 'A .vim link exists.'


