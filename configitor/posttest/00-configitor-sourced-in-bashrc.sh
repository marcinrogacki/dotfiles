#!/bin/sh
source $CONFIGITOR_BASE_DIR/.configitor/abstract.sh

configitor_bash_file_name=main.bashrc
configitor_bash_file=$CONFIGITOR_BASE_DIR/configitor/$configitor_bash_file_name

if ! grep -q "$configitor_bash_file" "$HOME/.bashrc"; then
    c_error 'Configitor is not sourced in ~/.bashrc file. Aliases will not work'
fi
c_success 'Configitor is sourced in ~/.bashrc. Aliases work.'
