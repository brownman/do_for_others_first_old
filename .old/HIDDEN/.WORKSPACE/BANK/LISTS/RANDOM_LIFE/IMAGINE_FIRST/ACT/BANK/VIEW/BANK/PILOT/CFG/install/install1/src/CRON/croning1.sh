#!/bin/bash

str1="$1"


info(){
/usr/bin/env -i $(cat /tmp/cron-env)
}
update_env(){
    #source /etc/profile
    source /home/$USER/.bashrc
}
run(){


    flite "restart $str1"
    if [ "$str1" = '' ];then
        flite 'no arguments'
    else
        info
       #update_env 
        action 
    fi

}
action(){
local file=/home/$USER/magnify_the_small/genius.sh
local cmd="$file one_cron \"$str1\""
local result=$( eval "$cmd" )
echo "$result"
}

run
#flite "finish $str1"
