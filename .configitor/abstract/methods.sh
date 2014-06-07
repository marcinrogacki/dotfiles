#!/bin/sh

################################################################################
# Include abstract.sh to include this file
################################################################################

get_timestamp() {
    echo `date +%s`
}

get_available_soft_file_path() {
    echo "$CONFIGITOR_BASE_DIR/.configitor/etc/soft_available.sh"
}

function _log() {
#    soft_name=$(cd `dirname $0` && echo ${PWD##*/})
#    soft_name=$global_soft_name
    current_dir=$(cd `dirname $0` && pwd)
    while read soft; do
        is_valid_soft=`echo $current_dir | grep "/$soft"`
        if [ -n "$is_valid_soft" ]; then
            soft_name="$soft"
        fi
    done < `get_available_soft_file_path`
    if [ -z "$soft_name" ]; then
        soft_name='configitor'
    fi
    echo -e "${1} <$soft_name> ${2}${3}${RCol}"
}

function c_log() {
    _log "[L]" "" "$1"
}

function c_success() {
    _log "[S]" $Gre "$1"
}

function c_info() {
    _log "[I]" $Yel "$1"
}

function c_error() {
    _log "[E]" $Red "$1"
    exit 1
}

function get_current_backup_dir_path() {
    backup_path=$HOME/.configitor.backup
    echo "$backup_path"
}

function create_backup() {
    soft=$1
    source=$2
    backup_path=`get_current_backup_dir_path`/$soft/$configitor_current_timestamp

    if [ -e $source ] && [ ! -h $source ]; then
        mkdir -p "$backup_path"
        c_info "Backuping: '$source' moved to dir '$backup_path'"
        mv "$source" "$backup_path"
    fi
}

make_symbolic_link() {
    target_dir="$1"
    target_file="$2" #can be dir
    target="$target_dir/$target_file"
    source="$3"

    target_check=`readlink "$target"`
    source_check=`readlink -f "$source"`
    if [ "$source_check" != "$target_check" ]; then
        unlink "$target" 2>/dev/null
        cd $target_dir
        ln -s "$source" "$target_file"
        cd - 1>/dev/null
        c_info "New symbolic: $target -> $source"
    fi
}

function fetch_by_git() {
    dir_where_is_submodule=$1
    module=$2

    c_log "Checking git submodule '$module', please wait."

    cd "$dir_where_is_submodule"
    info=`git submodule update --init $module | grep -o $module`
    if [ -n "$info" ]; then
        c_info 'Updated submodule: '$module
    fi 
    cd - 1>/dev/null
}

function compile_soft() {
    soft_dir=$1
    source_dir=$2
    install_dir=$3
    configure_params=$4
    log_dir=$soft_dir/var/log

    if [ ! -f $source_dir/configure ]; then
        c_error "Missing sources (configure file) in $source_dir"
    fi

    if [ ! -d $install_dir ]; then mkdir $install_dir; fi
    if [ ! -d $log_dir ]; then mkdir -p $log_dir ; fi
    touch $log_dir/configure.log
    touch $log_dir/configure.error
    touch $log_dir/make.log
    touch $log_dir/make.error
    touch $log_dir/install.log
    touch $log_dir/install.error

    c_log "Please wait, installing. Logs: $log_dir"
    
    c_log "configure"
    cd $source_dir
    ./configure $configure_params --prefix=$install_dir 1> $log_dir/configure.log 2> $log_dir/configure.error
    cd - 1> /dev/null

    c_log "make"
    make -C $source_dir 1> $log_dir/make.log 2> $log_dir/make.error
    
    c_log "install"
    make -C $source_dir install 1> $log_dir/install.log 2> $log_dir/install.error
}
