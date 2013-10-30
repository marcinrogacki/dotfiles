#!/bin/sh

script_dir=$(cd `dirname $0` && pwd)
source_dir=$script_dir/src

source $script_dir/../abstract.sh


case "${1:-''}" in
  'install')
    compile_soft
    ;;
  'help'|*)
    echo "params:"
    echo "install      install the soft/config"
    ;;
esac
