#!/bin/bash -e
file=$dir_tmp/cron.cfg
if [ ! -f $file ];then
	touch $file
fi

echo -n '' > $file

#echo -e "SHELL=${SHELL}\nPATH=${PATH}\n" >> $file 
echo -e "DISPLAY=${DISPLAY}\nSHELL=${SHELL}\nPATH=${PATH}\n" >> $file 
cat $dir_txt/crontab.txt >> $file
cat $file

echo 'update cron ?'
read answer
if [ "$answer" = y ];then
crontab $file
sudo service cron restart
else
echo "skip updating cron"
fi

