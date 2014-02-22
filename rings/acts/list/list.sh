#!/bin/bash -e
#$dir_script=/TORRENTS/SCRIPTS
#file=$dir_script/todo.txt
#file=/tmp/todo.txt
SOUND=false
path=`dirname $0`
lang=ru
subject=${1:-general_subject}
file=$path/list/$subject.txt
file_tmp=/tmp/list_$subject.tmp.txt
touch $file

run(){
    local line=$(gxmessage -file $file -title "$subject"  --timeout 30000 -entry )
    update_file "$line" "$file"
}
update_file(){
    local line="$1"
    local file=$2
    local time_stamp=`date | cut -d' ' -f4| cut -d':' -f1,2`

script_translate="$path/translation/translation.sh"
cmd="$script_translate $lang $line"
eval "$cmd"

    if [ "$line" = delete ];then
        echo -n '' > $file

    elif [ "$line" = exit ];then
        exit 1
    else
        tac $file > $file_tmp
        echo -e "$time_stamp\t$line" >> $file_tmp
        tac $file_tmp > $file
    fi
}


run
