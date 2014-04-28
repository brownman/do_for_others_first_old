#!/bin/bash

# about file:
#  
#
#
. $TIMERTXT_CFG_FILE
cyan 'edit.sh:'
title='edit.sh'


edit2(){




    #gedit $jobs_txt &

    #sleep1 $SLEEP


    str='update mindmap ?'
    answer=$( messageYN "$title" "$str" )
    #echo "return: $?"
    #echo "answer: $answer"
    if [ "$answer" = 2 ]
    then
        echo 'mindmap'
        xdg-open "http://drichard.org/mindmaps/#"
    fi



    str='edit .txt ?'
    answer=$( messageYN "$title" "$str" )
    if [ "$answer" = 2 ]
    then

        gedit $todo_txt &
        gedit $done_txt &
        gedit $rules_txt &
        gedit $readme_md &
        gedit $job_txt &
        gedit $timing_txt 

    fi

    str='update schedules ?'
    answer=$( messageYN "$title" "$str" )
    if [ "$answer" = 2 ]
    then

        ( xdg-open  $url_calendar &)
        ( xdg-open $url_tasks &)

    fi





    str='update wallpaper picture ?'
    answer=$( messageYN "$title" "$str" )
    if [ "$answer" = 2 ]
    then
        echo 'update wallpaper'
        $TASKS_DIR/wallpaper.sh
    fi

    str='find a job?'
    answer=$( messageYN "$title" "$str" )
    if [ "$answer" = 2 ]
    then
        echo 'update wallpaper'
        $TASKS_DIR/jobs.sh
    fi




}

str='update status ?'
answer=$( messageYN "$title" "$str" )
if [ "$answer" = 2 ]
then
    edit2
fi



