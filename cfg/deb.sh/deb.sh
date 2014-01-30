#!/bin/bash 

path=`dirname $0`
source $dir_cfg/arg/arg.cfg
source $dir_cfg/self/self.cfg


if [ "$1" ];then
    set_script_and_args "$@"
    cmd="$script ${args[@]}" 
    echo "$cmd"
    $( eval "$cmd" )
else
    show_options "$path/bin"
fi

