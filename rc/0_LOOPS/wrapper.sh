#!/bin/bash -e
#example: ./wrapper bin/0_sos/sos.sh
#set -o nounset
clear
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
    cat $0 | grep example -m1
fi

}
run
