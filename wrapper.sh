#!/bin/bash
let result=1
shopt -s expand_aliases
pushd `dirname $0`>/dev/null
set -o nounset
clear
file_log=$dir_root/log.txt
rm $file_log
touch $file_log

file_trace=$dir_root/trace.txt
rm $file_trace
touch $file_trace

file_clip=$dir_root/clipboard.txt
rm $file_clip
touch $file_clip



eval $dir_root/test.sh 2>$file_log
echo END
echo
if [ -s "$file_clip" ];then
    echo "[CLIPBOARD] nice"    
    str=`cat $file_clip`
    echo "$str"
    eval "$str"
else
    echo "[CLIPBOARD] raw"
    file=`cat $file_log | cut -d':' -f1`
    line=`cat $file_log | cut -d':' -f2 | sed 's/line//g' | sed 's/ //g' `
    msg=`cat $file_log | cut -d':' -f3`

    if [ -s "$file" ];then #check  if file is not empty
        if [ -n "$line" ];then
            cmd="vi $file +$line"
            echo "cmd: $cmd"
            echo -e "[CLIPBOARD UPDATED!]\t\t $cmd"
            cmd1="echo \"$cmd\" | /usr/bin/xsel --clipboard"
            echo "cmd1: $cmd1"

            /usr/bin/notify-send "$msg"
        else
            echo '[Error] parsing'

            echo print_color 31 [ERROR]
        fi
        echo print_color 31 '[LOG ERROR]'
        cat $file_log
        print_line
       let 'result=1'
    else

        echo -e '\t\tlogger is empty'
        let 'result=0'
        
    fi



fi

        echo '[END] wrapper.sh'
set +o nounset
exit $result
popd >/dev/null
