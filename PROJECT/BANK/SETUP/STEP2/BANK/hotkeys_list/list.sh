#!/bin/bash -e
#info:   hotkeys setup 
#imagine: calling the robot / and triggering workspace-gui-menu
#pending: update the list.txt
#details: update xfce hotkeys from a list.txt
steps(){
dir_self=`where_am_i $0`
file_list=$dir_self/list.txt
let 'counter=1'
while read line_cmd;do
#    echo "$line_cmd"
#    break

line="$( eval $line_cmd )"

cmd="hotkey_add $counter '$line'"
echo "[cmd] $cmd"
#proxy sleep 1
proxy "$cmd"
let 'counter+=1'
done<$file_list
}
steps
