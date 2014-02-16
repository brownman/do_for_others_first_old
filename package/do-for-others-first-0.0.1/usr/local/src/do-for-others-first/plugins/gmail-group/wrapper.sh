#!/bin/bash -e
dir=`dirname $0`


#update environments vars

file_cfg=$dir/vars.cfg
file_helpers=$dir/helpers.cfg

#test prequisites
file_test=$dir/test.sh

#run the actual script
file_script=$dir/script.sh

steps(){
    clear
    source $file_cfg
    source $file_helpers

    print_func

    $(exec $file_test)
    res=$?

        
    if [ "$res" = $SUCCESS ];then
      print_color 32 'run!'
        exec $file_script 2>$file_log
    else
      print_color 31 'follow the Instructions -> then try again!'
    fi
}


steps

