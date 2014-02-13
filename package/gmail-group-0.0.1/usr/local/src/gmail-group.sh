#!/bin/bash
#version:   0.0.1
#date:      12.2.2014
#depend:    gxmessage gmail-notify libnotify-bin
#help:      utilize shared gmail to act like the mobile application: whatsup 
#arguments: update your .bashrc with USER=gmail_nickname PASSWORD=gmail_passwort
#check:     ps -ef | grep gmail-notify | grep -v grep



run(){
    msg=$( gxmessage -entry -sticky -ontop -timeout 3000 -title "user: $user password:$password" "My Message:" )
    if [ "$msg" != '' ];then
        echo "$msg" > $file_compose
        cmd="curl -u $user:$password --ssl-reqd --mail-from advance.linux1@gmail.com --mail-rcpt advance.linux1@gmail.com --url smtps://smtp.gmail.com:465 -T $file_compose"
        echo "$cmd"
        eval "$cmd" #>/dev/null
    else
        echo 'skip sending'
    fi
}

steps(){
install
check
run
}

steps
