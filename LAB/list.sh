#!/bin/bash
reset
trap_sigint(){
    echo $FUNCNAME
vim $file_list 
}

dir_self=`where_am_i $0`
file_list=$dir_self/plan.yaml
trap trap_sigint SIGINT

step1(){
while read line;do
    echo $line
    sleep 2
done<$file_list
}


step1
