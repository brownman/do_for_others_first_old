#!/bin/bash

pushd `dirname $0` > /dev/null
#. $TIMERTXT_CFG_FILE
#dir=$TASKS_DIR
str1=""

PS3="Updating:" 
options=(  "Quit" "Delete" "Schedule" "Record & Publish" )


reset
blue  "update tasks" # | flite

select opt in "${options[@]}"
do

    case $opt in
        "Record & Publish")
            $tasks_sh present1
            ;;

        "Schedule")
            $TASKS_DIR/edit.sh
            echo 'write schedules and update X'

            echo 'fetch google calendar and tasks?'

            read answer
            if [ "$answer" = 'y' ]
            then
                echo 'fetch'
                $TASKS_DIR/fetch.sh
            fi
            echo 'send  report on email ?'
            read answer
            if [ "$answer" = 'y' ]
            then
                echo 'send  mail'
                $TASKS_DIR/mail.sh
            fi
            echo 'check mail ?'
            read answer
            if [ "$answer" = 'y' ]
            then
                echo 'get mail'
                $TASKS_DIR/mail2.sh
            fi
            ;;
        "Delete")
            echo 'delete txt files'
            $tasks_sh delete
            ;;
        "Quit")
            exit
            ;;
        "Unlock")
            yellow "I am aware of the time - let me go in !"
            break
            ;;
        *)
            reset
            ;;
    esac
done

green 'going on to submenu !' 
blue 'life is happend when you dont put notice'
cat $life_txt

popd > /dev/null
exit
