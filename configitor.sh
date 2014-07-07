#!/bin/sh

if [ -z $CONFIGITOR_BASE_DIR ]; then
    echo "Please provide an env variable: CONFIGITOR_BASE_DIR, e.g.:"
    echo "export CONFIGITOR_BASE_DIR=<absolute path to the configitor base dir>"
    exit 1
fi
if [ ! -f $CONFIGITOR_BASE_DIR/.configitor/abstract.sh ]; then
    echo "Invalid env variable: CONFIGITOR_BASE_DIR. It does not point to the"
    echo "configitor project. Please provide an absolute path to configitor dir:"
    echo "export CONFIGITOR_BASE_DIR=<absolute path to the configitor base dir>"
    exit 1
fi

. $CONFIGITOR_BASE_DIR/.configitor/abstract.sh

function show_help() {
    echo "Usage: sh `basename $0` [option]

option:
install         install softwares
test            run tests
help [option]   help for [option]
-h,--help       this message"

echo
echo "Messages:"
c_log       "LOG"
c_info      "INFO"
c_success   "SUCCESS"
c_error     "ERROR"

    exit 0
}

function run_command() {
    command=$1
    shift
    if [ -f $CONFIGITOR_BASE_DIR/.configitor/command/"$command".sh ]; then
        sh $CONFIGITOR_BASE_DIR/.configitor/command/"$command".sh "$@"
    else
       c_info "Invalid command: '${command}'. Try: sh `basename $0` --help"
       exit 1
    fi
}


command=$1
shift
case $command in
    'help')
        command=$1
        run_command "$command" "help"
        ;;
    -h|--help)
        show_help
        ;;
    *)
        run_command "$command" "$@"
        ;;
esac
