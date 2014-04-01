#!/bin/sh

script_dir=$(cd `dirname $0` && pwd)
source $script_dir/order.sh

for soft in $software_order
do
    should_i_install_soft=`echo ,$include, | grep $soft`
    if [ -z "$include" ] || [ -n "$should_i_install_soft" ]; then
        dir=$script_dir/$soft 
        if [ -f $dir/requirments.sh ]; then
            sh $dir/requirments.sh
        fi

        if [ -f $dir/test.sh ]; then
            sh $dir/test.sh
        fi
    fi
done
