#!/bin/bash -e
cmd="xfconf-query -c xfce4-keyboard-shortcuts -p \"/commands/custom/<Alt>F3\" -t string -s \"$PWD/wrapper.sh\" --create"
echo "$cmd"
echo confirm
read answer
if [ $answer = y ];then
    eval "$cmd"
else
    echo skipping 
fi

