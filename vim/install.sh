#!/bin/sh

script_dir=$(cd `dirname $0` && pwd)
source $script_dir/../abstract.sh

fetch_by_git 'src'
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

fetch_by_git '.vim/bundle/fuzzyfinder'
fetch_by_git '.vim/bundle/l9'
fetch_by_git '.vim/bundle/nerdtree'
fetch_by_git '.vim/bundle/phpcolors'
fetch_by_git '.vim/bundle/phpcomplete.vim'
fetch_by_git '.vim/bundle/tlib_vim'
fetch_by_git '.vim/bundle/vim-addon-mw-utils'
fetch_by_git '.vim/bundle/vim-pathogen'
fetch_by_git '.vim/bundle/vim-snipmate'
fetch_by_git '.vim/bundle/vim-unimpaired'
