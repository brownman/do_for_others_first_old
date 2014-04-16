#!/bin/bash
pushd `dirname $0`>/dev/null
let result=1
shopt -s expand_aliases
set -o nounset
clear
path=`dirname $0`
step1(){
    file_log=$path/txt/log.txt
    rm $file_log
    touch $file_log

    file_trace=$path/txt/trace.txt
    rm $file_trace
    touch $file_trace

    file_clip=$path/txt/clipboard.txt
    rm $file_clip
    touch $file_clip
}

step2(){
    eval $path/test.sh 2>$file_log
    echo
    if [ -s "$file_log" ];then
        echo print_color 31 '[LOG ERROR]'
        let 'result=1'
        if [ -d "$file_clip" ];then
            echo "[CLIPBOARD] ++"    
            str=`cat $file_clip`
            echo "$str"
            eval "$str"
        else
            echo "[CLIPBOARD] --"
            file=`cat $file_log | cut -d':' -f1`
            line=`cat $file_log | cut -d':' -f2 | sed 's/line//g' | sed 's/ //g' `
            msg=`cat $file_log | cut -d':' -f3`
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

            # cat $file_log
            # print_line
        fi
    else
        let 'result=0'
        echo -e '\t\tlogger is empty'
    fi
}
steps(){
    step1
    step2
}
steps


echo '[END] wrapper.sh'
set +o nounset
echo "$result" > $path/txt/result.txt
exit $result
popd >/dev/null
