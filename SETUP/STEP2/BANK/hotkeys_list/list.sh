#!/bin/bash
#info: update xfce hotkeys from a list.txt

dir_self=`dirname $0`
file_list=$dir_self/list.txt
let 'counter=3'
while read line;do
cmd="hotkey_add $counter \"$line\""
echo "$cmd"
proxy "$cmd"
let 'counter+=1'
done<$file_list
