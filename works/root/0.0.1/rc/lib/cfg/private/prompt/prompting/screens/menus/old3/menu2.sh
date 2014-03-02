#!/bin/bash

pushd `dirname $0` > /dev/null
#. $TIMERTXT_CFG_FILE

PS3="Coding:" 
options=( "Quit" "Collaborate" "Coding" "Testing" )


reset
select opt in "${options[@]}"
do

    case $opt in
        "Quit")
            exit
            ;;

        "Collaborate")
            echo 
            ;;

        "Testing")
            $TASKS_DIR/meditate.sh
            ;;


        "Coding")
            $TASKS_DIR/meditate.sh
            ;;

        *)
            reset
            ;;
    esac
done

popd > /dev/null
exit
