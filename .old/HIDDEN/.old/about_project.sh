#!/bin/bash -e
rm /tmp/proxy
set -o nounset
dir_self=`pwd`
file_list=$dir_self/list.txt
intro(){
    proxy "toilet --gay STRENGTH"
    echo pv pending
    echo pv tests

}

loop(){
    local file=''
    local    dir=""
    local cmd=''

    while read line;do
        dir="$line"
        cmd=''
        if [  -d "$dir" ];then
local cmd_clip="cd $dir"
update_clipboard "$cmd_clip"
            file="$dir/test.sh"

            if [  -f "$file" ];then
                cmd="$file"
                echo "$cmd"
                proxy          "$cmd"
            else
                proxy           reason_of_death 'no such file' "$file"
            fi
        else
            proxy   reason_of_death 'no such dir' "$dir"
        fi

    done<$file_list
}
steps(){
    intro
    loop
}



steps


set +o nounset
