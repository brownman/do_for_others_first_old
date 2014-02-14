#!/bin/bash -e
#version:   0.0.1
#date:      12.2.2014
#help:      run and save error logs
#arguments: a script to run
set -o nounset
set -o errtrace
#set -o verbose
#set -o
#confirm
pushd `dirname $0` > /dev/null



#vars
export SUCCESS=0
export FAILURE=1
export TRAP=false
export GUI=true

export BLUE=32
export RED=33
export GREEN=35

#first
dir_root=`pwd`

#dir-struct
export dir_rc=$dir_root/rc
export dir_plugins=$dir_root/plugins
export dir_lib=$dir_root/lib
export dir_shunit=$dir_lib/shunit2-2.0.3

#load
source $dir_rc/packagerc.fun

export file_runner=$dir_shunit/src/shell/shunit2

#assert 1 1

export script=$dir_root/bin/single.sh



#local

#declare -a args
args=()
time1=`date | cut -d' ' -f4 | sed 's/:/_/g'`
export file_error=~/Desktop/errors_$time1.txt






run(){
    print_func
    #dir_desktop=~/Desktop/$project_name/ERRORS
    #    if [  ! -d $dir_desktop ];then
    #    mkdir -$dir_desktop
    #fi

    if [ -f $file_error ];then
        rm $file_error
    fi
    #    touch $file_error
    if [ "${#args[@]}" -gt 0 ];then
        cmd="$script ${args[@]}"
    else
        cmd="$script"
    fi
#echo "$cmd"
confirm "$cmd"  2>$file_error 

    if [ ! -n $file_error ];then
        echo
        line=`cat $file_error`
        if [ "$line" ];then
            echo "ERRORS:"
            #    echo "File: $file_error"
            #        cat $file_error

            parse_primary "$line"
        else
            echo 'file error exist buy - No content' "$file_error"
        fi
    else
        echo "OK!"
        #echo "File: $file_error"
        #echo "is empty"
    fi

}
clear
print_script
echo -n  "Time: "
echo "$time1"
if [ $# -gt 0 ];then
    args=( "$@" )
else
    echo
#    show_funcs
  #  reason_of_death 'No Arguments'
fi
    run

#source $file_runner
popd
