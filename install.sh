#!/bin/sh

script_dir=$(cd `dirname $0` && pwd)
source $script_dir/abstract.sh

# run all install.sh scripts founded in subdirectories
for dir in $script_dir/*/
do
  dir=${dir%*/}
  if [ -f "$dir/install.sh" ]; then
    sh "$dir/install.sh"
  fi
done

# include bashrc stuff
bashrc=$HOME/.bashrc
if [ ! -f $bashrc ]; then
  touch $bashrc
  c_info "Created .bashrc file for user '`whoami`'."
fi


configitor_bash_file="bashrc.configitor"
load_bashrc_command="if [ -f $script_dir/$configitor_bash_file ]; then . $script_dir/$configitor_bash_file; fi"

if ! grep -q "$configitor_bash_file" "$HOME/.bashrc"; then
  echo "" >> $HOME/.bashrc
  echo "# [configitor] Please do not change below line" >> $HOME/.bashrc
  echo $load_bashrc_command >> $HOME/.bashrc
  c_info "Added configitor bashrc file into .bashrc of user '`whoami`'"
else
  ss='/'$configitor_bash_file'/c'$load_bashrc_command
  echo $ss > /tmp/configitor-sed
  sed -i -f /tmp/configitor-sed  $HOME/.bashrc
  rm /tmp/configitor-sed
fi

echo
echo "Messages:"
c_log       "LOG"
c_info      "INFO"
c_success   "SUCCESS"
c_error     "ERROR"
