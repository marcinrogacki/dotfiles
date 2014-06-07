#!/bin/sh

source $CONFIGITOR_BASE_DIR/.configitor/abstract.sh

soft_dir=$CONFIGITOR_BASE_DIR/vim
git_module="src"

fetch_by_git "$soft_dir" "$git_module"

source_dir=$soft_dir/src
install_dir=$soft_dir/bin
python_config="$CONFIGITOR_BASE_DIR/python/bin/lib/python3.4/config-3.4m"
configure_params='--enable-pythoninterp --with-python-config-dir='$python_config
compile_soft "$soft_dir" "$source_dir" "$install_dir"

original_vim_config_file=~/.vimrc
create_backup "vim" "$original_vim_config_file"

original_vim_config_dir=~/.vim
create_backup "vim" "$original_vim_config_dir"

vim_config_file=$CONFIGITOR_BASE_DIR/vim/.vimrc
make_symbolic_link ~ '.vimrc' "$vim_config_file" 

vim_config_dir=$CONFIGITOR_BASE_DIR/vim/.vim
make_symbolic_link ~ ".vim" "$vim_config_dir" 

fetch_by_git "$soft_dir" '.vim/bundle/fuzzyfinder'
fetch_by_git "$soft_dir" '.vim/bundle/l9'
fetch_by_git "$soft_dir" '.vim/bundle/nerdtree'
fetch_by_git "$soft_dir" '.vim/bundle/phpcolors'
fetch_by_git "$soft_dir" '.vim/bundle/phpcomplete.vim'
fetch_by_git "$soft_dir" '.vim/bundle/tlib_vim'
fetch_by_git "$soft_dir" '.vim/bundle/vim-addon-mw-utils'
fetch_by_git "$soft_dir" '.vim/bundle/vim-pathogen'
fetch_by_git "$soft_dir" '.vim/bundle/vim-snipmate'
fetch_by_git "$soft_dir" '.vim/bundle/vim-unimpaired'
