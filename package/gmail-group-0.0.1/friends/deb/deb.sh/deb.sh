#!/bin/bash

path=`dirname $0`
path_relative="$path/bin"
if [ $# -gt 0 ];then

   script=$1.sh
   arg="$2"
   cmd="$path_relative/$script $arg" 
echo "cmd: $cmd"
    confirm
    commander "$cmd"
else
    show_scripts "$path_relative"
fi

