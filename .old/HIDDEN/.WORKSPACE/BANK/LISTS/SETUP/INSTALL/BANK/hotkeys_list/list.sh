#!/bin/bash -e
#info:   hotkeys setup 
#imagine: calling the robot / and triggering workspace-gui-menu
#pending: update the list.txt
#details: update xfce hotkeys from a list.txt
     #xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Alt>F1" -t string -s "gvim $dir_root/plan.txt" --create

echo

# type install_hotkey
#reason: setup the hotkeys for the robot
#echo             xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/     <Alt>F1" -t string -s "gvim $dir_root/plan.txt" --create

steps(){
dir_self=`where_am_i $0`
file_list=$dir_self/list.txt
ln -sf $file_list /tmp/list.txt
let 'counter=1'
while read line_cmd;do
#    echo "$line_cmd"
#    break

line="$( eval $line_cmd )"

cmd="hotkey_set $counter \"$line\""
echo "[cmd] $cmd"
#proxy sleep 1
 eval "$cmd"  1>/dev/null
res=$?
if [ $res -ne 0 ];then
    echo ERROOOOOOOOR
    exit 1
    break
fi
let 'counter+=1'
done<$file_list
}
steps
