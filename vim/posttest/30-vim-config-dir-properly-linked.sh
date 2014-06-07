#!/bin/sh

source $CONFIGITOR_BASE_DIR/.configitor/abstract.sh

link=`readlink ~/.vim`
vim_conf_dir=`readlink -f $CONFIGITOR_BASE_DIR/vim/.vim`
if [ "$link" != "$vim_conf_dir" ]; then
  c_error 'A link of .vim config dir has filed.' 
fi
c_success 'A .vim config dir properly linked.' 
