#!/bin/bash  -e
clear
echo "flags: $-"
echo "shell level: $SHLVL"

dir=`dirname $0`
set -o nounset
set -o errtrace
set -o pipefail


#update environments vars

file_cfg=$dir/vars.cfg
file_helpers=$dir/helpers.cfg

#test prequisites
file_test=../../share/test.cfg

#run the actual script
file_script=$dir/script.sh

source $file_cfg
source $file_helpers
source $file_test

print_script
file_errors=/tmp/errors.txt
steps(){

    print_func



    $file_script 
   # 2>$file_errors 
   # echo
   # echo "file_errors: $file_errors"
   # cat $file_errors
}


steps

