#!/bin/bash
set -o nounset
echo "just suspend me!"
delay=300
path=`dirname $0`

let 'counter=0'
#str_remind="great! WOW! $counter"
str_remind="WhiteBoard Upgraded:---$counter---- times!         WoW!"
file=$path/share/suspend/wrapper.sh
while [ 1 ];do
    let 'counter+=1'
    file1=$counter.wow
    touch ~/Desktop/$file1
    xcowsay "$str_remind"


    if [ -f "$file" ];then
        echo "file:$file"
        eval "$file"
    else
        echo 'no such file' "$file"
        exit
    fi


    cmd="sleep $delay"
    echo "$cmd"
    eval "$cmd"

done
