#!/bin/bash
dir=`dirname $0`


#update environments vars

file_cfg=$dir/vars.cfg
file_helpers=$dir/helpers.cfg

#test prequisites
file_test=$dir/test.sh

#run the actual script
file_script=$dir/script.sh

steps(){
    source $file_cfg
    source $file_helpers
print_script
    print_func

    cmd="$file_test" 
    $( eval "$cmd" )

    res=$?

        
    if [ "$res" -eq $SUCCESS ];then
      print_color 32 'run!'
#        $( eval $file_script 2>$file_log )
$file_script
    else
      print_color 31 'follow the Instructions -> then try again!'
    fi
}


steps

