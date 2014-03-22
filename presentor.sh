#!/bin/bash -e
set -o nounset

file_steps=steps.txt
file_logger=logger.txt
export TIMEOUT_SLEEP=4

proxy(){
    if [ $# -gt 0 ];then
        cmd="$1"
        args=()
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
    args=( "$@" )
    cmd="${args[@]}"
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
    while read line;do
        proxy clear
        title=$(    echo "$line" | cut -d'#' -f1 )
        cmd=$(    echo "$line" | cut -d'#' -f2 )
        echo -ne "$title\t\t"

        commander "$cmd"
        proxy sleep "$TIMEOUT_SLEEP"
    done<$file_steps
}


steps

set +o nounset
