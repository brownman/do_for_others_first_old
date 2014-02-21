#!/bin/bash
echo "just suspend me!"


let 'counter=0'
    #str_remind="great! WOW! $counter"
    str_remind="WhiteBoard Upgraded:---$counter---- times!         WoW!"

while [ 1 ];do
    let 'counter+=1'
    file=$counter.wow
    touch ~/Desktop/$file
    xcowsay "$str_remind"

    cmd="$dir_ongoing/suspend/wrapper.sh"
    echo "$cmd"
    eval "$cmd"
    cmd="sleep 120"
    echo "$cmd"
    eval "$cmd"
done
