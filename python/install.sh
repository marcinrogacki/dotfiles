#!/bin/sh

source $CONFIGITOR_BASE_DIR/.configitor/abstract.sh

soft_dir=$CONFIGITOR_BASE_DIR/python
git_module="src"

fetch_by_git "$soft_dir" "$git_module"

source_dir=$soft_dir/src
install_dir=$soft_dir/bin

compile_soft "$soft_dir" "$source_dir" "$install_dir"
