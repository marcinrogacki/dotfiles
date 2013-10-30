#!/bin/sh

RCol='\e[0m'    # Text Reset

# Regular           Bold                Underline           High Intensity      BoldHigh Intens     Background          High Intensity Backgrounds
Bla='\e[0;30m';     BBla='\e[1;30m';    UBla='\e[4;30m';    IBla='\e[0;90m';    BIBla='\e[1;90m';   On_Bla='\e[40m';    On_IBla='\e[0;100m';
Red='\e[0;31m';     BRed='\e[1;31m';    URed='\e[4;31m';    IRed='\e[0;91m';    BIRed='\e[1;91m';   On_Red='\e[41m';    On_IRed='\e[0;101m';
Gre='\e[0;32m';     BGre='\e[1;32m';    UGre='\e[4;32m';    IGre='\e[0;92m';    BIGre='\e[1;92m';   On_Gre='\e[42m';    On_IGre='\e[0;102m';
Yel='\e[0;33m';     BYel='\e[1;33m';    UYel='\e[4;33m';    IYel='\e[0;93m';    BIYel='\e[1;93m';   On_Yel='\e[43m';    On_IYel='\e[0;103m';
Blu='\e[0;34m';     BBlu='\e[1;34m';    UBlu='\e[4;34m';    IBlu='\e[0;94m';    BIBlu='\e[1;94m';   On_Blu='\e[44m';    On_IBlu='\e[0;104m';
Pur='\e[0;35m';     BPur='\e[1;35m';    UPur='\e[4;35m';    IPur='\e[0;95m';    BIPur='\e[1;95m';   On_Pur='\e[45m';    On_IPur='\e[0;105m';
Cya='\e[0;36m';     BCya='\e[1;36m';    UCya='\e[4;36m';    ICya='\e[0;96m';    BICya='\e[1;96m';   On_Cya='\e[46m';    On_ICya='\e[0;106m';
Whi='\e[0;37m';     BWhi='\e[1;37m';    UWhi='\e[4;37m';    IWhi='\e[0;97m';    BIWhi='\e[1;97m';   On_Whi='\e[47m';    On_IWhi='\e[0;107m';

function _log() {
    soft_name=$(cd `dirname $0` && echo ${PWD##*/})
    echo -e "<$soft_name> ${1} ${2}${3}${RCol}"
}

function c_log() {
    _log "" "" "$1"
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

function compile_soft() {

    install_dir=$script_dir/bin
    var_dir=$script_dir/var

    if [ ! -f $source_dir/configure ]; then
        c_error "Missing sources (configure file) in $source_dir"
    fi

    if [ ! -d $install_dir ]; then mkdir $install_dir; fi
    if [ ! -d $var_dir ];     then mkdir $var_dir;     fi
    touch $var_dir/configure.log
    touch $var_dir/configure.error
    touch $var_dir/make.log
    touch $var_dir/make.error
    touch $var_dir/install.log
    touch $var_dir/install.error

    c_log "Please wait, installing. Logs in '$var_dir' dir"
    
    c_log "configure"
    cd $source_dir
    ./configure --prefix=$install_dir 1> $var_dir/configure.log 2> $var_dir/configure.error
    cd - 1> /dev/null

    c_log "make"
    make -C $source_dir 1> $var_dir/make.log 2> $var_dir/make.error
    
    c_log "install"
    make -C $source_dir install 1> $var_dir/install.log 2> $var_dir/install.error
}

