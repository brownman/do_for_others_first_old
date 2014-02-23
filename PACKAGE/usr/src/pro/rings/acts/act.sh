#!/bin/bash

pushd `dirname $0`
task_name=${1:-''}

if [ "$task_name" ];then
    path=`dirname $0`
    $path/$task_name/$task_name.sh
else
    echo 'supply a task name'
fi
popd
