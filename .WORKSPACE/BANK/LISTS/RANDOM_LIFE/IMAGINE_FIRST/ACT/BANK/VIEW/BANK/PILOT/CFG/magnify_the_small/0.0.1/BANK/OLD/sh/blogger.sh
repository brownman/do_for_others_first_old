#!/bin/bash
# about file:
# mission documentation:
# record your steps being done

#. $TIMERTXT_CFG_FILE

file=$1

trace "record your mission being done:"

trace "send $file to blogger ?"
read answer
if [ "$answer" = y ];then
google blogger post $file 
fi
#
#
#yellow 'send as email ?'
#read answer
#if [ "$answer" = y ];then
#
#$TASKS_DIR/mail.sh
#$TASKS_DIR/mail2.sh
#
#fi
#
#yellow 'upload new video to youtube ?'
#read answer
#if [ "$answer" = y ];then
#url1=https://www.youtube.com/upload
#chromium-browser $url1
#fi

