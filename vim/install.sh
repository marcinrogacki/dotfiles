#!/bin/sh

script_dir=$(cd `dirname $0` && pwd)
source $script_dir/../abstract.sh

git submodule update $script_dir/src
python_config="$script_dir/../python/bin/lib/python3.4/config-3.4m"
compile_soft '--enable-pythoninterp --with-python-config-dir='${python_config}


if [ ! -h ~/.vimrc ] && [ -f ~/.vimrc ]; then
    create_backup_dir
#    mv ~/.vimrc $script_dir/backup
    c_info 'A .vimrc file has beed moved to '$script_dir'/backup'
fi

if [ ! -h ~/.vim ] && [ -d ~/.vim ]; then
    create_backup_dir
#    mv ~/.vim $script_dir/backup
    c_info 'A .vim dir has beed moved to '$script_dir'/backup'
fi

if [ -h ~/.vimrc ]; then
    unlink ~/.vimrc
fi
if [ -h ~/.vim ]; then
    unlink ~/.vim
fi

cd ~/
ln -s $script_dir/.vimrc
ln -s $script_dir/.vim
cd - 1>/dev/null

git submodule update $script_dir/.vim/bundle/fuzzyfinder
git submodule update $script_dir/.vim/bundle/l9
git submodule update $script_dir/.vim/bundle/nerdtree
git submodule update $script_dir/.vim/bundle/phpcolors
git submodule update $script_dir/.vim/bundle/phpcomplete.vim
git submodule update $script_dir/.vim/bundle/tlib_vim
git submodule update $script_dir/.vim/bundle/vim-addon-mw-utils
git submodule update $script_dir/.vim/bundle/vim-pathogen
git submodule update $script_dir/.vim/bundle/vim-snipmate
git submodule update $script_dir/.vim/bundle/vim-unimpaired
