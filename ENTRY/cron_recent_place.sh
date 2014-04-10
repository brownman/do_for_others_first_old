#!/bin/bash
export dir_root=~/JAIL/TREE
#source $dir_root/.bashrc_additions
exec 2>/tmp/err
trap_err(){
gxmessage -file /tmp/err -title trap_err -entry
}
trap trap_err ERR
#set -o nounset
( flite -t 'there is only 1 true thing to do now - and you know it really really good' )&
#every 2 "$cmd"
recent_place(){
(    flite -t "I choosed to do for others first" &) # must not use proxy!
#cmd="gxmessage -entry -file /tmp/plan -title breakthrough -timout $timeout"
#local str="$time:    $( \"$cmd\" )"
#file_update "$file" "$str"

local file_places="$dir_root/LIST/recent_places.txt"
local str=$( cat $file_places | head -1 )
local cmd="gxmessage -timeout 5 -entrytext \"$str\" -title 'recent_places' -file \"$file_places\" -sticky"
local cmd1=$( eval  "$cmd" )
if [ -n "$cmd1" ];then
( proxy "$cmd1" )&
else
    ( proxy  "gvim $file_places" )&
    fi

}

steps(){
recent_place
}
steps
