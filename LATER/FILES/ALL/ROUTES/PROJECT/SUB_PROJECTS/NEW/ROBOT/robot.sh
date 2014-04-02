#!/bin/bash -e
set -o nounset

exprts(){
  echo
}


vars(){
echo
}

proxy(){
    local args=( "$@" )
    cmd="${args[@]}"
    eval "$cmd"

}

notify(){
    xcowsay "$msg"
    flite -t "$msg"
}


act(){
    (    eval "$cmd" 1>/dev/null 2>/dev/null ) 
    local res=$?
    if [ "$res"  -eq 1 ];then
        msg='the robot want to learn about this new command' 
    else
        msg='at your service'
        proxy "$cmd"
    fi
    notify "$msg"
}



if [ "$#" -gt 0 ];then
    args=( "$@" )
    cmd="${args[@]}"
    act
else
    msg='give me a mission please - I am smarter than you'
    notify "$msg"
fi

set +o nounset
