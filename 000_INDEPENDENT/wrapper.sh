#!/bin/bash -e
#set -o nounset
export dir_root=`pwd`
source struct.cfg
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
