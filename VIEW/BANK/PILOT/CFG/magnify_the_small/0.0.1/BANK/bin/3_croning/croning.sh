#!/bin/bash -e
#the cron installer use crontab to call to itself
#options: install new crontab OR to be called by a cron job
echo 'hello'
path=`pwd`
time1=`date | cut -d' ' -f4`
file_log=$path/log.txt

install(){
    #check: crontab -l
    echo 'install()'
    file=$path/crontab.txt
    echo
    echo "File: $file"
    echo
    cat $file 
    echo 'install this new crontab ?'
    read answer
    if [ "$answer" = y ];then
        crontab $file
    else
        echo 'skipping'
    fi
    echo
    echo
}



steps(){
    echo 'steps()'
    if [ "${#args[@]}" -gt 0 ];then
        xcowsay "${args[@]}"
    else
        notify-send 'croning' 'no arguments'
    fi
}

echo start
cmd=${1:-steps}

if [ "$#" -gt 0 ];then

shift
args=( "$@" )
fi

echo -e "$time1:\t$cmd ${args[@]}" >> $file_log
$cmd 


echo 'bye'
