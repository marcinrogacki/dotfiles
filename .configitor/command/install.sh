#!/bin/sh

script_dir=$(cd `dirname $0` && pwd)
. $script_dir/../abstract.sh

show_help() {
echo "
Usage: sh `basename $0` [option]
    
option:
--soft          filters softwares to install. List separeted by colon
                (order is not important) e.g. --soft vim,python,ctags"

    exit 0;
}

while test $# -gt 0; do
    case "$1" in
        --soft)
            shift
            soft_allowed="$1"
            shift
            ;;
        help)
            show_help
            ;;
        *)
            shift
            ;;
    esac
done

while read soft; do
    is_soft_requested=`echo ",${soft_allowed}," | grep $soft`
    if [ -z "$soft_allowed" ] || [ -n "$is_soft_requested" ]; then
        dir=$script_dir/../../$soft 
        sh $script_dir/test.sh --soft "$soft" --type pretest

        if [ -f "$dir/install.sh" ]; then
            sh "$dir/install.sh"
        fi

        sh $script_dir/test.sh --soft "$soft" --type posttest 
    fi
done < $script_dir/../etc/order.sh
