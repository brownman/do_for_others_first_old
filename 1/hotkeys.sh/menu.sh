#!/bin/bash

path=`dirname $0`
dir_cfg=$path/cfg
source $dir_cfg/zenity.cfg

#file_hotkeys=$path/hotkeys.txt
#if [ ! -f $file_hotkeys ];then
#    touch $file_hotkeys
#fi

#dir=../$file_hotkeys/
#if [ ! -h $dir/$file_hotkeys ];then
#    ln -s $file_hotkeys $dir
#fi

dir=../$path
if [ ! -h $dir/$file_hotkeys ];then
    ln -s $file_hotkeys $dir
fi

result=$( zenity1 $file_hotkeys )
notify-send "$result"
