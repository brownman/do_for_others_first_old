#!/bin/bash -e
#info: file update using a gui dialog box
echo "script:list.sh"
set -o nounset
#$dir_script=/TORRENTS/SCRIPTS
#file=$dir_script/todo.txt
#file=/tmp/todo.txt
pushd `dirname $0`

    script_translate="$translate_sh"
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
        line=$(gxmessage -file $file -title "$subject"  --timeout $secs -entry $GXMESSAGE )
  #  done
    update_file "$file" "$line" 
}
remove_trailing(){
    echo "$@" tr -s " "
}

update_file(){

    local file=$1
    local line="$2"
    local time_stamp=`date | tr -s " " | cut -d' ' -f4| cut -d':' -f1,2`
if [ -n "$line" ];then
    echo 'translating' "$line"
    cmd="$script_translate $lang $line"
    echo "$cmd"
    eval "$cmd"
fi
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
