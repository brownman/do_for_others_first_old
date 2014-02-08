#!/bin/bash
#name: update todo list 
#description:  pop-up a dialog wich consist of 2 boxes: 1.for showing the usage history, and , 2.a input box
#depend-gui: gxmessage
#depend-cli: bash
#use: write a line which describe your current focus
#changing:  workspace/plugin-name/todo.txt
plugin_name='todo'
dir=$dir_workspace/$plugin_name
file=$dir/$day.txt
file_tmp=/tmp/todo.txt
timeout=10
if [ ! -d "$dir" ];then
    #Assume: struct.cfg created the $dir_workspace
    mkdir "$dir"
fi

if [ ! -f "$file" ];then
    touch $file
fi
if [ ! -f "$file_tmp" ];then
    touch $file_tmp
fi



run(){
    local line=$( gxmessage -file $file -title 'think small:' -timeout $timeout -entry -ontop -sticky )
    update_file "$line" "$file"
}
update_file(){
    local line="$1"
    local file=$2

    local time_stamp=`date | cut -d' ' -f5`
    
speak "$line"

    if [ "$line" ];then
        #str=`echo "$line" | sed 's/ /_/g'`
        #file1="~/Desktop/$rounds.txt"
        #echo "$str" >> "$file1"
        if [ "$line" = delete ];then
            echo -n '' > $file
        else
            tac $file > $file_tmp
            #
            echo "$time_stamp $line" >> $file_tmp
            tac $file_tmp > $file
            price 60
        fi
    else
        unprice
    fi
}


run
