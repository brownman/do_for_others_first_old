#!/bin/bash -e
set -o nounset

file_list=steps.txt
file_logger=logger.txt
export TIMEOUT_SLEEP=4
update_clipboard(){
local cmd="$1"
echo "$cmd" | xsel --clipboard
}
proxy(){
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
        proxy sleep 2
        echo -ne "------->"
proxy sleep 2
        echo -ne "\t------->"
        #proxy xcowsay "$title"

}
steps(){
    let 'counter=1'
    while read line;do
        proxy clear
        local title=$(    echo "$line" | cut -d'#' -f1 )
        local cmd=$(    echo "$line" | cut -d'#' -f2 )
        echo -ne "$title\t\t"
        update_clipboard "vi $file_list +${counter}"
        commander "$cmd"
        proxy sleep "$TIMEOUT_SLEEP"
        let 'counter+=1'
    done<$file_list
}


steps

set +o nounset
