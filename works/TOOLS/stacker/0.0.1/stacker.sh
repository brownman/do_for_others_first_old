#!/bin/bash -e
path=`dirname $0`
source $path/config.cfg


if [ $# -gt 0 ];then
    args=( "$@" )
    cmd="${args[@]}"
    eval "$cmd"
    
    
else
    reason_of_death 'no arguments'

fi

