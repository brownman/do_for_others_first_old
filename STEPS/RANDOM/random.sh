#!/bin/bash -e
clear
#set -o  errtrace
dir=`pwd`
echo "dir: $dir"
source $dir/helper.cfg
file_list=$dir/list.txt 
run(){
   echo print_func
    while read line;do
        if [ "$line" != '' ];then
#            cmd="every2 $line"
#            echo "cmd: $cmd"
          echo  sleep1 2
            every2 "$line"
        else
            echo  "encounterd empty line on $file_list"
            echo exit
            exit
        fi
    done < $file_list
}
run
