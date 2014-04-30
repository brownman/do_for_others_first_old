#!/bin/bash

path=`dirname $0`
step1(){
    proxy notify-send '2.now in: $path'
    #dir_cfg=$dir_project/cfg/general


    #source $dir_cfg/color/colors.cfg
    file_hotkeys=$path/hotkeys.txt

    if [ ! -f "$file_hotkeys" ];then
        touch $file_hotkeys
        echo "notify-send I'm alive"
        proxy    green "done installing $path/hotkeys.txt"
    fi
    #if [ ! -f $file_hotkeys ];then
    #    touch $file_hotkeys
    #fi

    #dir=../$file_hotkeys/
    #if [ ! -h $dir/$file_hotkeys ];then
    #    ln -s $file_hotkeys $dir
    #fi

    if [ -s "$file_hotkeys" ];then

        cmd="zenity1 $file_hotkeys"

        result=$( "$cmd" )
        if [ "$result" ];then
            eval "$result"
        fi
    else
        result="invalid file: $file_hotkeys"

    fi

    proxy    notify-send "$result"
}
steps(){
    step1
}
steps
