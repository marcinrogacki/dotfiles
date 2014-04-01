#!/bin/sh

script_dir=$(cd `dirname $0` && pwd)
source $script_dir/../abstract.sh

git submodule update $script_dir/src
compile_soft
