#!/bin/bash 

path=`dirname $0`
path_relative="$path/bin"
if [ "$1" ];then
    
    argr "$path_relative $@"
    cmd="$script ${args[@]}" 
    blue 'Executing:'
    echo "cmd: $cmd"
    eval "$cmd"
else
    show_scripts "$path_relative"
fi

