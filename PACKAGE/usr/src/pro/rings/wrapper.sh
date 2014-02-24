#!/bin/bash -e
#set -o nounset
export dir_root=`pwd`
source setup.cfg
task=${1:-''}

run(){


if [ "$task" ];then
   cmd="$task" 
   echo "$cmd"
   eval "$cmd"
else
    echo "supply a task"
fi

}
run
