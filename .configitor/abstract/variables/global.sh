#!/bin/sh

if [ -z $global_abstract_variables_included ]; then
    global_abstract_variables_included=1
    global_soft_name=''

    source_dir=$script_dir/src
    install_dir=$script_dir/bin
    var_dir=$script_dir/var
    log_dir=$var_dir/log
fi
