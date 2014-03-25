#!/bin/bash -e
set -o nounset

path=`pwd`
pushd "$path">/dev/null

dir_txt=$path/txt
dir_cfg=$path/cfg
[ ! -d "$dir_cfg" ] && mkdir $dir_cfg
[ ! -d "$dir_txt" ] && mkdir $dir_txt

file_list=$path/list.txt
file_logger=$dir_txt/logger.txt
export TIMEOUT_SLEEP=4
update_clipboard(){
local cmd="$1"
echo "$cmd" | xsel --clipboard
}
proxy1(){
    if [ $# -gt 0 ];then
       local cmd="$1"
        
      local   args=()
        shift

        if [ $# -gt 0 ];then
            args=( "$@" )

            commander "$cmd ${args[@]}"
        else

            commander "$cmd"
        fi

    fi
}
commander(){
local     args=( "$@" )
 local    cmd="${args[@]}"
echo "$cmd" >> $file_logger

eval "$cmd"
}
sleeper(){
        proxy1 sleep 2
        echo -ne "------->"
proxy1 sleep 2
        echo -ne "\t------->"
        #proxy1 xcowsay "$title"

}
steps(){
    let 'counter=1'
    while read line;do
        proxy1 clear
        local title=$(    echo "$line" | cut -d':' -f1 )
        local cmd=$(    echo "$line" | cut -d':' -f2 )
        echo -ne "$title\t\t"
        update_clipboard "vi $file_list +${counter}"
        commander "$cmd"
        proxy1 sleep "$TIMEOUT_SLEEP"
        let 'counter+=1'
    done<$file_list
}


steps
popd>/dev/null
set +o nounset
