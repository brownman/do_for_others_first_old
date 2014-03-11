#!/bin/bash

path=`dirname $0`
dir_log=$path/.log
if [ -d "$dir_log" ];then
    file_error=$dir_log/error
    num="${1:-1}"
    sleep "$num"
    eval "$path/croning.sh $num" 2>$file_error

    echo

    cat $file_error
    cmd="gxmessage -file $file_error -title 'wrap croning'"
    [ ! -f $file_error  ] || eval "$cmd"

else
    reason_of_death 'invalid directory' "$dir_log"
fi




