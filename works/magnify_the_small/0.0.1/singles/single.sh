#!/bin/bash  -e

echo -e "\t\t\tscript: single.sh"
notify-send "single.sh" "$@"
set -o nounset
path=`dirname $0`
pushd "$path">/dev/null
#######################set args
######################################
task_name=${1:-''}
if [ $# -gt 0 ];then
shift
    args=( "$@" )
else
    args=()
fi
#########################################

if [ -n "$task_name" ];then

echo "TASK_NAME: $task_name"
    script=$task_name/$task_name.sh
    if [ ! -f  "$script" ];then
        reason_of_death 'invalid script' "$script"
        
    fi
else
#    print_layout

    tree -L 2
    reason_of_death 'supply a task name'
fi

#${@:-''}
##############################
run(){



    if [ -f "$script" ];then
        if [ "${#args[@]}" -gt 0 ];then
        words="${args[@]}"
        notify-send "$task_name" "$words" 
        sleep 5
        
        cmd="$script ${args[@]}"
        eval "$cmd"
        else
        eval "$script"
        fi
    else
        echo reason_of_death 'invalid task name' "$task_name"
        reason_of_death 'no such file:' "$script"
    fi

}
run
popd>/dev/null
