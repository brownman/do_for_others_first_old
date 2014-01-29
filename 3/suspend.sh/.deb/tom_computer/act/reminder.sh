#!/bin/bash -e

#change between false and true - to mute / unmute
mute=false
dir_script=`dirname $0`
file_tmp=/tmp/crontab.txt
file=$dir_script/reminder.txt
cmd=${1:-'run'}

minutes_reminder=1
minutes_todo=1


run(){
local line=$(random_line $file)
notify-send "$line" & 
if [ "$mute" = false ];then

echo "$line" | flite -voice slt &
sleep 1
echo "$line" | flite -voice kal &
sleep 1
echo "$line" | flite -voice awb &
fi
}


random_line(){
local file=$1
local line=$(shuf -n 1 $file)
echo "$line"
}
run


