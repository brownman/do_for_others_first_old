#!/bin/bash

# about file:
# proxy to next script: test/menu/..

export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE
reset 


if [ "$1" = "test" ];then
    echo 'test'
    $tasks_sh "$2" "$3" 
elif [ "$1" = "periodic" ];then
    #pids1 "$0" 
    $SCREENS_DIR/periodic.sh
elif [ "$1" = 'menus' ];then
    $PUBLIC_DIR/menus.sh
elif [ "$1" = 'koans' ];then
        $KOANS_DIR/meditate.sh 
else #lazy loading
    cyan 'DO FOR OTHERS IDEA ?'
    read answer
    if  [ "$answer" != '' ];then
        echo "$answer" >> $DYNAMIC_DIR/day/others.txt 
    else
        $tasks_sh suspend
    fi

    cat $CFG_DIR/workflow.txt | head -3
    white 'edit workflow ?'
    read answer
    if  [ "$answer" = 'y' ];then
        gedit $CFG_DIR/workflow.txt
    fi

fi




