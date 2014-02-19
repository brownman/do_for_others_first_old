#!/bin/bash 
#version:   0.0.1
#date:      12.2.2014
#help:      run and save error logs
#arguments: a script to run
#set -o nounset
#set -o errtrace
#set -o verbose
#set -o
#confirm
pushd `dirname $0` > /dev/null
dir_project=`pwd`
#source setup.cfg

#vars
export SUCCESS=0
export FAILURE=1
export TRAP=false
export GUI=true
export EDITOR=vi


export RED=31
export GREEN=32
export BLUE=34
export YELLOW=33
export PINK=35

#first
source setup.cfg

script=$dir_project/bin/single.sh



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
    eval "$cmd" 
    #2>$file_error 

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
        print_color $GREEN End.
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