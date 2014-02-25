#!/bin/bash

path=`dirname $0`

notify-send "2.now in: $path"
#dir_cfg=$dir_project/cfg/general


#source $dir_cfg/color/colors.cfg
file_hotkeys=$dir_workspace/hotkeys.txt

if [ ! -f "$file_hotkeys" ];then
    touch $file_hotkeys
    echo "notify-send I'm alive"
    green "done installing $path/hotkeys.txt"
fi
#if [ ! -f $file_hotkeys ];then
#    touch $file_hotkeys
#fi

#dir=../$file_hotkeys/
#if [ ! -h $dir/$file_hotkeys ];then
#    ln -s $file_hotkeys $dir
#fi

if [ -s "$file_hotkeys" ];then
    result=$( zenity1 "$file_hotkeys" 2>/dev/null )
    if [ "$result" ];then
        eval "$result"
    fi
else
    result="invalid file: $file_hotkeys"
fi

    notify-send "$result"

