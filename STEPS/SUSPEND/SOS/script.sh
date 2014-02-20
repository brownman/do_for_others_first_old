#!/bin/bash
echo "just suspend me!"


let 'counter=0'

while [ 1 ];do
    let 'counter+=1'
    xcowsay "great! WOW! $counter"
    cmd="$dir_ongoing/suspend/wrapper.sh"
    echo "$cmd"
    eval "$cmd"
    cmd="sleep 120"
    echo "$cmd"
    eval "$cmd"
done
