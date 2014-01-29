#!/bin/bash -e

#change between false and true - to mute / unmute
mute=false

path=`dirname $0`

file_tmp=/tmp/crontab.txt
file=$dir_script/reminder.txt
cmd=${1:-'run'}

minutes_reminder=1
minutes_todo=2
minutes_suspend=5

generate(){
local file=$1
echo -e "DISPLAY=:0
*/$minutes_reminder * * * * bash -c $dir_script/reminder.sh
*/$minutes_todo * * * * bash -c  $dir_script/todo.sh
*/$minutes_suspend * * * * bash -c  $dir_script/suspend.sh" > $file
}


install(){
if [ ! -f $file_tmp ];then
	echo "creating file $file"
	touch $file_tmp
fi
generate $file_tmp

clear
cat $file_tmp
echo update cron job ?

read answer
if [ "$answer" = y ];then
crontab $file_tmp
sudo service cron restart
else
echo skip updating cron
fi
}


install

