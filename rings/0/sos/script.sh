#!/bin/bash
set -o nounset
echo "just suspend me!"


let 'counter=0'
#str_remind="great! WOW! $counter"
str_remind="WhiteBoard Upgraded:---$counter---- times!         WoW!"

while [ 1 ];do
    let 'counter+=1'
    file1=$counter.wow
    touch ~/Desktop/$file1
    xcowsay "$str_remind"


    file=$dir_coderc/suspend/wrapper.sh
    if [ -f "$file" ];then
        echo "file:$file"
        eval "$file"
    else
        echo 'no such file' "$file"
        exit
    fi


    cmd="sleep 120"
    echo "$cmd"
    eval "$cmd"

done
