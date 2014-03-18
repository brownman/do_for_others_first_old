#!/bin/bash 
#echo "\t\t\tscript: act.sh"
set -o nounset

path=`dirname $0`
pushd "$path">/dev/null
#######################set args
task_name=${1:-''}

if [ $# -gt 0 ];then

shift
    args=( "$@" )
else
    args=()
fi

#${@:-''}
##############################
run(){


if [ "$task_name" ];then
    script=$path/$task_name/$task_name.sh

    if [ -f "$script" ];then
        if [ "${#args[@]}" -gt 0 ];then
        words="${args[@]}"
        notify-send "$script" "$words" 
        sleep 5
        eval "$script ${args[@]}"
        else
        eval "$script"
        fi
    else
        echo reason_of_death 'invalid task name' "$task_name"
        reason_of_death 'no such file:' "$script"
    fi
else
    print_layout
    reason_of_death 'supply a task name'
fi

}
run
popd>/dev/null
