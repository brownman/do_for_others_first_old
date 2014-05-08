#!/bin/bash

# about file:
#  
#
#

. $TIMERTXT_CFG_FILE
pushd `dirname $0` > /dev/null


#SCRIPTPATH1=`pwd -P`
#. ./cfg/timer.cfg
#echo "password:$PASS1"
file3=/tmp/missions.txt
file1=/tmp/file1.txt
file2=/tmp/file2.txt

file_name=/tmp/gcalcli_agenda.txt
file_name2=/tmp/gcalcli_agenda_full.txt


file_task=/tmp/task
file_token=/tmp/token


echo 'fetch google-tasks' 'file: $file3'
echo 'curl'
curl https://www.google.com/accounts/ClientLogin \
-d Email="$USER1@gmail.com" \
-d Passwd="$PASS1" \
-d source=privacylog \
-d service=goanna_mobile > $file_token

AUTH=$(sed -n 's/Auth=/auth=/p' $file_token)
HEADER="Authorization: GoogleLogin $AUTH"
URL="https://mail.google.com/tasks/ig"
curl --header "$HEADER" "$URL" > $file_task



grep -o "\"\(name\|notes\)\":\"[^\"]*\"" $file_task > $file1
cat $file1 | awk -F : '{print $2}' | sed 's/\\n//g' | sed 's/"//g' > $file2
cat $file2 | head  -n -1 > $file3
cat $file3

gcalcli --cal brownman-calendar --nc --ignore-started agenda "`date --date='08:00am'`" "`date --date='23:59'`" > $file_name 
cat $file_name
gcalcli --cal brownman-calendar --nc --ignore-started agenda "`date --date='08:00am'`" "`date --date='23:59'`" > $file_name2 
#gcalcli 
  #'gxmessage -display :0 -center \
                                         #-title "Ding, Ding, Ding!" %s'
popd > /dev/null
