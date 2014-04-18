#!/bin/bash
#info:   hotkeys setup 
#imagine: calling the robot / and triggering workspace-gui-menu
#pending: update the list.txt
#details: update xfce hotkeys from a list.txt
dir_self=`dirname $0`
file_list=$dir_self/list.txt
let 'counter=3'
while read line;do
cmd="hotkey_add $counter \"$line\""
echo "$cmd"
proxy "$cmd"
let 'counter+=1'
done<$file_list

