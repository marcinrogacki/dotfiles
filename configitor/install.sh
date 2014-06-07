#!/bin/sh

source $CONFIGITOR_BASE_DIR/.configitor/abstract.sh

function show_help() {
echo "Usage: sh `basename $0`

Installs aliases for softs."

    exit 0;
}

while test $# -gt 0; do
    case "$1" in
        help)
            show_help
            ;;
        *)
            shift
            ;;
    esac
done

# include bashrc stuff
bashrc=$HOME/.bashrc
if [ ! -f $bashrc ]; then
  touch $bashrc
  c_info "Created .bashrc file for user '`whoami`'."
fi

configitor_bash_file_name=main.bashrc
configitor_bash_file=$CONFIGITOR_BASE_DIR/configitor/$configitor_bash_file_name
load_bashrc_command="if [ -f $configitor_bash_file ]; then . $configitor_bash_file; fi"

if ! grep -q "$configitor_bash_file" "$HOME/.bashrc"; then
  echo "" >> $HOME/.bashrc
  echo "# [configitor] Please do not change below line" >> $HOME/.bashrc
  echo $load_bashrc_command >> $HOME/.bashrc
  c_info "Added configitor bashrc file into .bashrc of user '`whoami`'"
else
  ss='/'$configitor_bash_file_name'/c'$load_bashrc_command
  echo $ss > /tmp/configitor-sed
  sed -i -f /tmp/configitor-sed  $HOME/.bashrc
  rm /tmp/configitor-sed
  c_info "Configitor entry in ~/.bashrc was updated"
fi
