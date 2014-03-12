#!/bin/bash

################################## start
path_self=`dirname $0`
if [ "$#" -gt 0  ];then
args=( "$@" )
else
    reason_of_death 'supply arguments'
fi
#########################################

set_env(){
    /usr/bin/env -i $(cat $path_self/.usr.env)
}
set_user(){
    if [ "$(id -u)" != "0" ]; then
        user='user'
    else
        user='root'
    fi
    notify-send "$user"
}         
run(){
    pushd "$PWD">/dev/null
    cmd="${args[@]}"
    echo "[COMMAND]" 
    echo "$cmd"
    sleep 2
    eval "$cmd" 2>$file_error
    popd>/dev/null
}
wrap_runner(){
    file_error=$dir_log/error
    [ -f "$file_error"  ] && rm $file_error
    run
    if [ -s "$file_error"  ];then
        cat $file_error
        cmd="gxmessage -file $file_error -title 'wrap errors'"
    else
        cmd="gxmessage -title 'wrap errors' 'file_error is clean :)'"
    fi
    eval "$cmd"
}

set_dir_for_logs(){
    dir_log=$path_self/log
    if [ -d "$dir_log" ];then
        tree -L 2 $dir_log
        echo
    else
        reason_of_death 'invalid directory' "$dir_log"
    fi



}


steps(){
    #    set_user
    #    set_env
    set_dir_for_logs
    wrap_runner
}
steps
