#!/bin/bash

pushd `dirname $0` > /dev/null
#. $TIMERTXT_CFG_FILE
#dir=$TASKS_DIR
str1=""

PS3="Updating:" 
options=(  "Quit" "Schedule" "next version !" )


reset
blue  "update tasks" # | flite

select opt in "${options[@]}"
do

    case $opt in
        "Quit")
            exit
            ;;
   
        "Schedule")
            echo 'update/share schedules'
            $MENUS_DIR/menu1.sh
            ;;
   

        "next version !")
            echo 'update uml design ?'
            echo 'update workflow'
            gedit $idea_txt
            ;;
        *)
            reset
            ;;
    esac
done
