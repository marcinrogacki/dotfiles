#!/bin/sh

script_dir=$(cd `dirname $0` && pwd)
source_dir=$script_dir/src

source $script_dir/../abstract.sh

case "${1:-''}" in
  'install')
    compile_soft
    ;;
  'alias')
    home_relative_path=${install_dir#$HOME}/bin/ctags
    if [ ! -f $HOME$home_relative_path ]; then
        echo "Ctags is not installed"
        return
    fi

    bash_aliases=$HOME/.bash_aliases
    if [ ! -f $bash_aliases ]; then
        touch $bash_aliases
    fi

    bin_path='$HOME'$home_relative_path
    comment='# ctags software installed for this user'
    alias='alias ctags="'$bin_path'"' 

    if ! grep -q "$alias" "$bash_aliases"
    then
        echo "" >> $bash_aliases
        echo $comment >> $bash_aliases
        echo $alias >> $bash_aliases
        echo 'Done. Please reload bash aliases. Command:'
        echo 'source ~/.bash_aliases'
    fi
    ;;
  'help'|*)
    echo "params:"
    echo "install      install the soft/config"
    ;;
esac
