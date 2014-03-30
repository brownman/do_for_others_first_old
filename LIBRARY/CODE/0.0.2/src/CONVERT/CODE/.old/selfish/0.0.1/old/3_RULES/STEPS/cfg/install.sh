#!/bin/bash  -e

#pushd `dirname $0`
set -o nounset
set  -o errtrace

str_msg_start='start'
str_msg_end='end'

step1(){
#dir=`dirname $0`
str_ptrn="export dir_root=$PWD;source $PWD/setup.cfg"
cmd=`echo $str_ptrn`
ptrn=`eval "$cmd" `
}


source $PWD/cfg/basic.cfg

run(){
    print_color 32 "$str_msg_start"


    echo -e "searching for pattern:\n $ptrn"

    cmd="grep ${ptrn} ~/.bashrc"
    echo "cmd: $cmd"
    result=$( eval "$cmd" )
    echo  "result: $result"


    if [ "$result" = '' ];then
        echo "no results"
        print_color 31 "your ~/.bashrc is missing a line which load this project"
        sleep 1
        echo "LINE: $ptrn"
        sleep 1
        echo "adding this line to your: ~/.bashrc"
        sleep 2
        cmd="echo \"$ptrn\" >> ~/.bashrc"
        echo "cmd: $cmd"
        eval "$cmd"
        sleep 1 
        print_color 32 "DONE!"
    else
        echo "results:ok"
        echo "PROJECT ALREADY SUCCESSFULY INSTALLED !"
        #echo "your ~/.bashrc file contains a line that loads this project's setup"
        cmd="grep setup.cfg ~/.bashrc --color=auto"
        echo "cmd: $cmd"
        eval "$cmd"
        echo "lets load it now!"
        sleep 5
        source ~/.bashrc
    fi

    print_color 32 "$str_msg_end"
}
steps(){
step1
}

sleep 10
#set +o nounset
