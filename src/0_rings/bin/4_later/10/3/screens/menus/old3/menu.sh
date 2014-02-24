#!/bin/bash

pushd `dirname $0` > /dev/null
#. $TIMERTXT_CFG_FILE
#dir=$TIMER2_DIR



PS3="Main Menu:"


reset
#echo "$str2"
#cyan  "\t\t\t\t Parent Menu" 
options=("Quit"   "update" "job" "buy" "code" )
select opt in "${options[@]}"
do
    #echo "my status is:"

    case $opt in
        "Quit")
            exit
            ;;

        "update")
            echo 'update'
            $MENUS_DIR/menu1.sh
            ;;
     "job")
            echo 'update'
            $MENUS_DIR/menu4.sh
            ;;
     "buy")
            echo 'update'
            $MENUS_DIR/menu3.sh
            ;;
     "code")
            echo 'update'
            $MENUS_DIR/menu2.sh
            ;;


        *)
            exiting
            ;;

    esac
done

popd > /dev/null
exit
