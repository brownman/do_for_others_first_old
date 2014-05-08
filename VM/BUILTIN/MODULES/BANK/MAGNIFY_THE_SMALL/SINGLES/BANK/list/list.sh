#!/bin/bash
set -e
set -o nounset
#options: update list with a string or commands: exit / delete
#info: file update using a gui dialog box

#path=`dirname $0`
#pushd "$path">/dev/null
secs=7

subject=${1:-general_subject}
dir_tmp=/tmp
#$dir_workspace/lists/txt/
file=/tmp/$subject.txt
file_tmp=/tmp/list_$subject.tmp.txt
[ ! -f $file ] && { touch $file; }

msg(){
    local line=''
  #  while [ "$line" = '' ];do
        line=$(gxmessage -file $file -title "$subject"  --timeout $secs -entry $GXMESSAGE )
  #  done
    [ -n "$line" ] && { update_file "$file" "$line" ;}
}
remove_trailing(){
    echo "$@" tr -s " "
}

update_file(){

    local file=$1
    local line="$2"
    local time_stamp=`date | tr -s " " | cut -d' ' -f4| cut -d':' -f1,2`
    if [ "$line" = delete ];then
        echo -n '' > $file
    elif [ "$line" = exit ];then
        exit 1
    else
        tac $file > $file_tmp
        echo -e "$time_stamp\t$line" >> $file_tmp
        tac $file_tmp > $file
    fi
    echo "$line"
}

run(){
msg
}
run
#popd>/dev/null
