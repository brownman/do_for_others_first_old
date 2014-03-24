#!/bin/bash -e
set -o nounset
################################## start
args=()
#path_self=`dirname $0`
if [ "$#" -gt 0  ];then
    args=( "$@" )
else
    echo reason_of_death 'supply arguments'
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
    #    pushd "$PWD">/dev/null
    echo

    #   popd>/dev/null
}
wrap_runner(){
    #info:   run a command in a sub-shell +  notify about errors
    #depend: $file_error $file_out ${args[@]}
    if [ ${#args[@]} -gt 0 ];then
        local cmd="${args[@]}"
        local cmd1=''
        [ -f "$file_error"  ] && rm $file_error
        [ -f "$file_out"  ] && rm $file_out
        ##################################    run##########
        echo -ne "[COMMAND] " 
        echo "$cmd"
        eval "$cmd" 2>$file_error 1>$file_out
        ######################################################3
        if [ -s "$file_error"  ];then
            cmd1="gxmessage -file $file_error -title 'wrap errors'"
            eval "$cmd1"
        fi
        if [ -s "$file_out"  ];then
            cmd1="cat $file_out"
            eval "$cmd1"
        fi
    else
        echo reason_of_death 'no arguments'
    fi
}

set_dir_for_logs(){
    dir_log=$path_self/log
    if [ -d "$dir_log" ];then
        tree -L 2 $dir_log
        #echo
    else
        proxy reason_of_death 'invalid directory' "$dir_log"
    fi



}


steps(){
    #    set_user
    #    set_env
    #    set_dir_for_logs
    wrap_runner
}
steps
set +o nounset
