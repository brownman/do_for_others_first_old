#!/bin/bash 

path=`dirname $0`
if [ "$1" ];then
    
    set_script_and_args_dont_kill "$@" 
    cmd="$path/bin/$script.sh ${args[@]}" 
    blue 'Executing:'
    echo "$cmd"
    eval "$cmd"
else
    show_options "$path/bin"
fi

