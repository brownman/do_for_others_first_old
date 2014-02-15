#!/bin/bash
#version:   0.0.1
#date:      12.2.2014
#depend:    gxmessage gmail-notify libnotify-bin
#help:      utilize shared gmail to act like the mobile application: whatsup 
#arguments: update your .bashrc with USER=gmail_nickname PASSWORD=gmail_passwort
#check:     ps -ef | grep gmail-notify | grep -v grep

user=$GMAIL_USER
password=$GMAIL_PASSWORD 

run(){
    print_func
    msg=$( gxmessage -entry -sticky -ontop -timeout 3000 -title "user: $user password:$password" "My Message:" )
    if [ "$msg" != '' ];then
        echo -e "$LOGNAME:\t $msg" > $file_compose
        cmd="curl -u $user:$password --ssl-reqd --mail-from $LOGNAME<$user@gmail.com> --mail-rcpt advance.linux1@gmail.com --url smtps://smtp.gmail.com:465 -T $file_compose"
        echo "$cmd"
        xsel "$cmd"
        eval "$cmd" #>/dev/null
    else
        notify-send 'skip sending'
    fi
}

run

