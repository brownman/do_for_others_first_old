#!/bin/bash

pushd `dirname $0` > /dev/null
#. $TIMERTXT_CFG_ILE

PS3="creativity"
options=( "Quit" "Play timer" "Update .sh" "Next menu" "motivation" "idea" "game" "security" "efficiency" ) 


reset
white  "config" # | flite
select opt in "${options[@]}"
do

    case $opt in
        "Quit")
            exit
            ;;
 

        "security")
            echo 'security hole'

            echo 'check system security:'



            ( xterm -e 'sudo lynis --check-all -Q' &)

            vi /usr/sbin/lynis
            ;;

        "game")

$timer_sh     learn1
            echo 'memory game'
            $timer_sh game 

            ;;
        "idea")
            echo "add idea:"
            read answer

            if [ "$answer" != '' ];then
                echo "$answer" >> $ideas_txt 
            fi
            cat -n $ideas_txt
            ;;
       "efficiency")
            echo "add efficient idea:"
            read answer

            if [ "$answer" != '' ];then
                echo "$answer" >> $efficiency_txt 
            fi
            cat -n $efficiency_txt
            ;;

        "motivation")
            echo "everything is funny actualy"
            read answer

            if [ "$answer" != '' ];then
                echo "$answer" >> $motivations_txt 
            fi
            cat -n $motivations_txt
            ;;

         "Play timer")
           # play2 &
            $timer_sh play1 
            ;;
        "Update .sh")
            echo2 "edit .cfg/.sh files" 
           #vi $TASKS_DIR/cfg/timer.cfg
vi $TIMERTXT_CFG_FILE
            ;;

        *)
            echo '*'
            ;;
    esac
done

popd > /dev/null
exit
