#!/bin/bash -e
#$dir_script=/TORRENTS/SCRIPTS
#file=$dir_script/todo.txt
#file=/tmp/todo.txt
path=`dirname $0`
file=$path/list.txt
file_tmp=/tmp/todo.tmp.txt
touch $file

run(){
    local line=$(gxmessage -file $file -title 'todo' --timeout 30000 -entry )
    update_file "$line" "$file"
}
update_file(){
    local line="$1"
    local file=$2
    local time_stamp=`date | cut -d' ' -f4| cut -d':' -f1,2`
    if [ "$line" = delete ];then
        echo -n '' > $file
    else
        tac $file > $file_tmp
        echo -e "$time_stamp\t$line" >> $file_tmp
        tac $file_tmp > $file
    fi
}


run
