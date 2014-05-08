#!/bin/bash 

breaking(){
    local str0=`caller`
    local str="gvim +$str0"
    echo "goto : $str"

    proxy print_color 31 'breaking'
    echo breaking
    break
}



single(){
    local dir_self=`dirname $0`
    local input="$input"
    if [ -n "$input" ];then
        local file="$dir_self/wrapper.sh"
        #zbab
        if [ -f "$file" ];then
            local cmd="bash -xc  \"$file $input\""; \ 
            echo "[ try ] $cmd"
            proxy sleep 4
            ( eval "$cmd" )
        else
            echo 'no such file ' "$file"
        fi
    else
        echo no input "$input"
        breaking

    fi





}


loop(){
    #zbab1
    local counter_death=0
    while [ 1 ];do
        local cmd="set -o nounset"
        proxy "every 5 \"$cmd\""
        proxy "cowsay \"new life: $counter_death\""
        single
        proxy sleep 2
        let 'counter_death+=1'
    done
}

steps(){
    eval "$cmd_trap"
    loop 
}
args=( $@ )
input="${args[@]}"
steps 
