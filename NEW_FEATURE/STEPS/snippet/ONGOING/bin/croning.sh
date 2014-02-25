#!/bin/bash
user=''

if [ "$(id -u)" != "0" ]; then
    user='user'
else
    user='root'
fi


time1=`date | cut -d' ' -f4 | sed 's/:/_/g'`
file=/home/dao04/Desktop/${time1}_${user}.txt
touch $file
crontab -l > $file 

flite -t "$user"
notify-send "$user"
xcowsay "$user"
#gxmessage -file $dir_workspace/cron/crontab.user.txt -title "$user"


