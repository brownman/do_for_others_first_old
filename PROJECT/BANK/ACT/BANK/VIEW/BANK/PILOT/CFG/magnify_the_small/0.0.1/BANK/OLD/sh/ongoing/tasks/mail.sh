#!/bin/bash

# about file:
#  
#
#



export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE

echo 'mail.sh: make me effective!'
#vim - comment all selected linese: to:,ic from:,rc 
#how to remember? i see = ic

#echo $TIMERTXT_CFG_FILE
. $TIMERTXT_CFG_FILE

#$TIMER_DIR
#/missions.txt
#ls -l  $missions_txt
#thanks_txt=$DAILY_DIR/thanks.txt
#essay_txt=$ESSAYS_DIR/essay.txt
wallpaper_file=/tmp/result.png

photo1(){

    #background=/tmp/result.png

    pic_file=$(echo ~/pictures/webcam-$(date +%m_%d_%Y_%H_%M).jpeg)
    ffmpeg -y -r 1 -t 3 -f video4linux2 -vframes 1 -s sxga -i /dev/video0 $pic_file && Xloadimage $pic_file

    txt_file=$(echo ~/pictures/done-$(date +%m_%d_%Y_%H_%M).txt)




xloadimage $mind_map_png &
    convert /tmp/result.png -resize 640x480 /tmp/result.png
    ( xloadimage $wallpaper_file &) 

    xloadimage $pic_file &
}

send1(){

    echo "send1() got: $1"
    local y=\$"$1"   # Name of variable (not value!).
    #echo $y    # $Junk

    local x=`eval "expr \"$y\" "`
    #echo $1=$x
#    echo  "$1 " 
#    echo "$x"
#    cat $x

local str=$( echo $1 | sed 's/_txt//g' )
    mpack -s "my $str" "$x" "$MAIL1 , $MAIL2" 

}
send2(){

    echo "send2() got: $1"
    file=$1
    mpack -s "my report" $file "$MAIL1 , $MAIL2" 
}

#
#photo1
#str=$( gxmessage -title 'press no for cancel the sending to Kuka' -file  "$missions_txt" -timeout 10 -entry )
#if [[ $str != 'no'  ]]
#then
#
#
#    echo 'sleep 10 seconds !'
#    sleep 10s
#
##

##send1 schedule_txt
###send1 missions_txt
##send1 timing_txt 
##send1 todo_txt
##send1 done_txt
##send1 wallpaper_file
##send1 mind_map_png
###send1 report_txt
#
#else
#    notify_send 'not sending !'
#
#fi


send2 $TODAY_DIR/txt/report.txt
photo1
send1 pic_file
