#!/bin/bash

################################## start
path=`dirname $0`
num="${1:-1}"
echo "using the default task: $num"
sleep "$num"
#########################################

set_env(){
    /usr/bin/env -i $(cat $path/.usr.env)
}
set_user(){
    if [ "$(id -u)" != "0" ]; then
        user='user'
    else
        user='root'
    fi
    notify-send "$user"
}         
set_timing(){
time=`date | tr -s ' ' | cut -d' ' -f4 | sed 's/:/_/g'`

notify-send "set timing" "$time"
time_minute=`echo "$time" | cut -d':' -f3`

notify-send "set timing" "$time_minute"

}


run(){
    task_index=$(set_timing)
    eval "$path/croning.sh $num" 2>$file_error
}
wrap_runner(){
    file_error=$dir_log/error
    [ -f $file_error  ] && rm $file_error
    run
    cat $file_error
    cmd="gxmessage -file $file_error -title 'wrap croning'"
    [ -s $file_error  ] && eval "$cmd"
}

set_dir_for_logs(){
    dir_log=$path/.log
    if [ -d "$dir_log" ];then
        tree -L 2 $dir_log
        echo
    else
        reason_of_death 'invalid directory' "$dir_log"
    fi



}


steps(){
    set_user
    set_env
    set_dir_for_logs
    wrap_runner
}
steps
