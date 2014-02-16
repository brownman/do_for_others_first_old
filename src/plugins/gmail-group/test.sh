#!/bin/bash 
#author:    ofer shaham
#plugin:    gmail-group
#package:   do-for-others-first
#version:   0.0.1
#date:      15.2.2014
#depend:    gxmessage gmail-notify libnotify-bin curl
#help:      utilize shared gmail to act like the mobile application: whatsup 
#arguments: update your .bashrc with USER=gmail_nickname PASSWORD=gmail_passwort
#check:     ps -ef | grep gmail-notify | grep -v grep

#31 - red
#32 - green
#33 - yellow
print_script
let "result=$SUCCESS"

test(){
   # echo "$0"
    print_func

    ########################## Test Requirements: ##################################\   
    ################################################################################\


    ########################## install dependencies ######################\   
    list=`pull depend`
    for item in $list;do
        cmd="dpkg -L $item"
        eval "$cmd" >/dev/null 2>&1 || { echo >&2 "Please Run: sudo apt-get install $item" ;let "result=$FAILURE"; }
    done

    ########################### test if gmail-notify is running ##########\

    cmd=`pull check`
    str=`eval "$cmd"`
    [ -z "$str" ] && { echo >&2 "Please Run: gmail-notify" ;let "result=$FAILURE"; }


    ########################### test if the user update the default configurations ##########\

    [ -z "$user" ] && { echo -e >&2 "Please Open: vars.cfg\nAnd Edit: your Gmail settings" ;let "result=$FAILURE"; }
    

return $result
}

test


