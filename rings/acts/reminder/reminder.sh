#!/bin/bash
set -o nounset 

#change between false and true - to mute / unmute
mute=false
dir_script=`dirname $0`
file=$dir_script/list.txt
cmd=${1:-'run'}

minutes_reminder=1
minutes_todo=1


run(){
    echo 'run()'
local line=$(random_line $file)
if [ "$line" ];then


notify-send "$line" & 
if [ "$mute" = false ];then

echo "$line" | flite -voice slt &
sleep 1
echo "$line" | flite -voice kal &
sleep 1
echo "$line" | flite -voice awb &
else
    echo "mute:" "$line"
fi

fi
}


random_line(){
#    echo 'random_line()'
local file="$1"
if [ -f "$file" ];then
local line=$( shuf -n 1 $file ) 
echo "$line"
else 
    echo 'no such file' "$file"
fi
}
run


