#!/bin/bash -e
echo "\t\t\tscript: act.sh"
set -o nounset

pushd `dirname $0`

    path=`dirname $0`
task_name=${1:-''}
shift
args=${@:-''}

if [ "$task_name" ];then

    script=$path/$task_name/$task_name.sh
    
    if [ -f "$script" ];then
        echo "$script $args"
        eval "$script $args"
    else
        echo 'no such file:' "$script"
        exiting
    fi
else
    echo 'supply a task name'
    exiting
fi
popd
