#!/bin/bash

pushd `dirname $0` > /dev/null
#. $TIMERTXT_CFG_FILE

PS3="Scraping:"
options=( "Quit" "Scraping" )


reset
select opt in "${options[@]}"
do

    case $opt in

        "Quit")
            exit
            ;;
        "Scraping")
            echo 'scraping for: language-website? deals?'
            echo 'google forms + xpath'
            ;;


        *)
            reset
            ;;
    esac
done

popd > /dev/null
exit

