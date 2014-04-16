#!/bin/bash
exec 2>/tmp/err
export dir_root=~/JAIL/TREE
source $dir_root/.trick.cfg

proxy(){
local    args=( $@ )
local     cmd="${args[@]}"
    echo "$cmd" >> /tmp/proxy
    eval "$cmd"
}
trap_err(){
    notify-send error $?
gxmessage -file /tmp/err -title trap_err -entry
}
trap trap_err ERR
export -f trap_err
#set -o nounset
every 5 "flite -t 'there is only 1 true thing to do now - what is it'"
#every 2 "$cmd"
recent_place(){

every 5 " flite -t 'I choosed to do for others first'  # must not use proxy!"
#cmd="gxmessage -entry -file /tmp/plan -title breakthrough -timout $timeout"
#local str="$time:    $( \"$cmd\" )"
#file_update "$file" "$str"

local file_places="$dir_root/LIST/recent_places.txt"
local str=$( cat $file_places | tail -1 )
local cmd="gxmessage -timeout 5 -entrytext \"$str\" -title 'recent_places' -file \"$file_places\" -sticky"

local cmd1=$( eval  "$cmd" )
if [ -n "$cmd1" ];then
    echo "$cmd1" >> $file_places
 proxy "$cmd1" 
else
    #(killall -9 gvim 2>/dev/null &)
 proxy   "gvim $file_places" 
    fi

}

steps(){
recent_place
}
steps
