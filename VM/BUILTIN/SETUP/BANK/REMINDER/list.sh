#!/bin/bash
clear
trap_sigint(){
    echo $FUNCNAME
exec gvim $file_list 
}

dir_self=`where_am_i $0`
file_list=$dir_self/list.txt
trap trap_sigint SIGINT

step1(){
while read line;do
    echo $line
    sleep 2
done<$file_list
}


step1
