#!/bin/bash 

path=`dirname $0`
path_relative="$path/bin"
if [ $# -gt 0 ];then
    
    arg_soft "$path_relative $@"
    cmd="$script ${args[@]}" 
    
    echo  "$cmd"
    confirm
    commander "$cmd"
else
    show_scripts "$path_relative"
fi

