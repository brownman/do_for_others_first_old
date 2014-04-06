#!/bin/bash 
#info: simple lister: run every line at list.txt
#question: is 'let 'x=9' is local?
set -o nounset

path=`pwd`
pushd "$path">/dev/null
file_list=$path/list.txt

#clean_file "$file_list_orig"


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

flag_char "$line" "#"
local res=$?
if [ "$res" -eq 1  ];then

        echo -ne "$title\t\t"
        local cmd1="pushd `dirname $file_list`;vi $file_list +${counter}"
        update_clipboard  "$cmd1"
        assert string_has_content "$cmd"
        echo proxy "$cmd"
    else
        proxy xcowsay  "[PENDING] $title"
    fi
        #proxy1 sleep "$TIMEOUT_SLEEP"
        let 'counter+=1'
    done<$file_list
}


create_dirs
step1
popd>/dev/null
set +o nounset
