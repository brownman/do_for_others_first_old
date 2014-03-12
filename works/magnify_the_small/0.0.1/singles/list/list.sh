#!/bin/bash -e
echo "script:list.sh"
set -o nounset
#$dir_script=/TORRENTS/SCRIPTS
#file=$dir_script/todo.txt
#file=/tmp/todo.txt
pushd `dirname $0`
SOUND=false
path=`dirname $0`
secs=7
lang=ru
subject=${1:-general_subject}
file=$dir_workspace/lists/txt/$subject.txt
file_tmp=/tmp/list_$subject.tmp.txt
touch $file

msg(){
    local line=''
  #  while [ "$line" = '' ];do
        line=$(gxmessage -file $file -title "$subject"  --timeout $secs -entry )
  #  done
    update_file "$line" "$file"
}
remove_trailing(){
    echo "$@" tr -s " "
}

update_file(){
    local line="$1"
    local file=$2
    local time_stamp=`date | tr -s " " | cut -d' ' -f4| cut -d':' -f1,2`

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

run(){
msg
}
run
popd
