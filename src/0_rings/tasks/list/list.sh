#!/bin/bash -e
echo "script:list.sh"
set -o nounset
#$dir_script=/TORRENTS/SCRIPTS
#file=$dir_script/todo.txt
#file=/tmp/todo.txt
pushd `dirname $0`
SOUND=false
path=`dirname $0`
dir_root=../../
source $dir_root/setup.cfg

lang=ru
subject=${1:-general_subject}
file=$path/txt/$subject.txt
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

script_translate="$translate_sh"
cmd="$script_translate $lang $line"
echo "$cmd"
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
popd
