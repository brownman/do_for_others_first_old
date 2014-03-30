#!/bin/bash -e
clear
path=`dirname $0`
source $path/cfg/config2.cfg


if [ $# -gt 0 ];then
    args=( "$@" )
    cmd="${args[@]}"

    
    
else

cmd=`cat $path/.history`
#    reason_of_death 'no arguments'
confirm "$cmd"
fi

    eval "$cmd"

