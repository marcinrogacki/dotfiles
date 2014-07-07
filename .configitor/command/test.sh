#!/bin/sh

. $CONFIGITOR_BASE_DIR/.configitor/abstract.sh

show_help() {
    echo "Usage: sh `basename $0` [option]

option:
--soft name,name,...        which soft should be tested
--type [pretest|posttest]   test type 
help                        this message"

    exit 0
}

# @param $1 pretest|posttest
run_test() {
    type=$1
    is_type_supported=`echo ,pretest,posttest, | grep ",${type},"`
    if [ -z "is_type_supported" ]; then
        c_error 'configitor' "Test type '${type}' is not supported"
    fi

    dir=$script_dir/../../$soft 
    if [ -d $dir/$type/ ]; then
        for file in `find $dir/$type/ -name "*.sh" | sort`; do
            sh $file
        done
    fi
}

while test $# -gt 0; do
    case "$1" in
        --soft)
            shift
            soft_allowed="$1"
            shift
            ;;
        --type)
            shift
            testtype="$1"
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
    is_soft_requested=`echo ",$soft_allowed," | grep $soft`
    if [ -z "$soft_allowed" ] || [ -n "$is_soft_requested" ]; then
        if [ -n "$testtype" ]; then
            run_test $testtype 
        else
            run_test pretest
            run_test posttest 
        fi
    fi
done < $CONFIGITOR_BASE_DIR/.configitor/etc/order.sh
