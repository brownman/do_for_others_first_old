#!/bin/bash
#info: manage calls for all gists
#reason: run gists by calling them through this central proxy script.
#depand_cmd: gvim gxmessage notify-send tree
clear

source /home/dao05/.bashrc

exec 2>/tmp/err
proxy(){
    local args=( $@ )
    local cmd="${args[@]}"
    echo "$cmd" >> /tmp/proxy
    eval "$cmd"
}

trap_err(){
    local title=$FUNCNAME
    local str_caller=`caller`
    echo $title
    local cmd=$( gxmessage -file /tmp/err -entrytext "gvim +${str_caller}" -title $title )
    proxy "$cmd"
    exit 1
}
clean_file(){
    local file=$1
    [ -s $file ] && { file_print $file; /bin/rm $file; }
}
cleanup(){
    clean_file /tmp/proxy
    clean_file /tmp/err
}
file_print(){
    local file=$1
    echo
    echo $file
    echo '-------'
    cat $file
    echo
}

steps(){
    cmd="$dir_bank/${args[@]}"
    notify-send $0 "$cmd"
    eval "$cmd"
}
    cleanup
    trap trap_err ERR

    args=( $@ )
    dir_self=`where_am_i $0`
    dir_bank=$dir_self/BANK

if [ $# -gt 0 ];then

    file_script=$dir_bank/${args[0]}
    if [ -f $file_script ];then
        steps
    else
        echo "ERROR - no such file: $file"
    fi

else
    echo -e "\t\t\tOPTIONS:"
    echo '----------'
    ls -1 $dir_self/BANK
fi
