#!/bin/bash

current_dir=`dirname $0`
log_dir=$current_dir/log
filename=suspend
#notify-send "$log_dir"
file=$log_dir/$filename.log
if [ -f $file ];then

gxmessage -file $file -title logger -timeout 30000
str=`date | cut -d' ' -f4 | sed 's/:/_/g'`
mv $file $log_dir/backup/$str.log
else
notify-send "error: no such file" "$file"
fi

