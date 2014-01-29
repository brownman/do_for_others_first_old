#!/bin/bash -e
dir_script=`dirname $0`
file=$dir_script/todo.txt
file_tmp=/tmp/todo.txt
touch $file

run(){
local line=$(gxmessage -file $file -title 'todo' --timeout 30000 -entry )
update_file "$line" "$file"
}
update_file(){
local line="$1"
local file=$2

local time_stamp=`date | cut -d' ' -f4`



if [ "$line" = delete ];then
echo -n '' > $file
else
tac $file > $file_tmp
#
echo "$time_stamp $line" >> $file_tmp
tac $file_tmp > $file
fi
}


run
