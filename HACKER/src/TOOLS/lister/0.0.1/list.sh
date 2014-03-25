#!/bin/bash -e
#question: is 'let 'x=9' is local?
set -o nounset

path=`pwd`
pushd "$path">/dev/null
file_list=$path/list.txt
export TIMEOUT_SLEEP=4


create_dirs(){
    dir_txt=$path/txt
    dir_cfg=$path/cfg
    ensure dir_exist "$dir_cfg"
    ensure dir_exist "$dir_txt"

file_logger=$dir_txt/logger.txt
}

step1(){
    let 'counter=1'
    while read line;do
        #proxy1 clear
        local title=$(    echo "$line" | cut -d':' -f1 )
        local cmd=$(    echo "$line" | cut -d':' -f2 )
        echo -ne "$title\t\t"

        local cmd1="pushd `dirname $file_list`;vi $file_list +${counter}"
        update_clipboard  "$cmd1"
        assert string_has_content "$cmd"
        proxy "$cmd"
        #proxy1 sleep "$TIMEOUT_SLEEP"
        let 'counter+=1'
    done<$file_list
}


create_dirs
step1
popd>/dev/null
set +o nounset
