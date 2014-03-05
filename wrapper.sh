#!/bin/bash
pushd `dirname $0`>/dev/null
set -o nounset
clear
file_log=$dir_root/log.txt
rm $file_log
touch $file_log

./test.sh 2>$file_log
echo
echo

file=`cat $file_log | cut -d':' -f1`
line=`cat $file_log | cut -d':' -f2 | sed 's/line//g' | sed 's/ //g' `
msg=`cat $file_log | cut -d':' -f3`

if [ -s "$file" ];then #check  if file is not empty
    if [ -n "$line" ];then
        cmd="vi $file +$line"
        echo -e "[CLIPBOARD UPDATED!]\t\t $cmd"
        echo "$cmd" | /usr/bin/xsel --clipboard

        /usr/bin/notify-send "$msg"
    else
        echo '[Error] parsing'

        print_color 31 [ERROR]
    fi

    cat $file_log
else
    echo -n [OK]
    echo -e '\t\tlogger is empty'
fi

set +o nounset

popd >/dev/null
