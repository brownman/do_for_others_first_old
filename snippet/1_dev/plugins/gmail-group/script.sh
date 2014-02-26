#!/bin/bash -e
#author:    ofer shaham
#plugin:    gmail-group
#describe:      utilize shared gmail to act like the mobile application: whatsup 
#package:   do-for-others-first
#version:   0.0.1
#date:      15.2.2014
#check_depend_package:    gxmessage gmail-notify libnotify-bin curl
#check_depend_config: user password
#check_depend_process:     gmail-notify
#hint: update your .bashrc with USER=gmail_nickname PASSWORD=gmail_passwort
#31 - red
#32 - green
#33 - yellow

print_script
set -o nounset
echo "shell level: $SHLVL"



run(){
    print_func
    echo -e "user:$user\npassword:some_lie\nfrom:$from\nto:$to" > $file_msg

    if [ -f "$file_msg" ];then

        cmd="gxmessage -title 'compose' -entry -file $file_msg $MSG_EXT"  
        echo "$cmd"
        local    msg=$( eval "$cmd" )
        if [ "$msg" != '' ];then
            echo -e "$LOGNAME- $msg" > $file_compose
            cmd="curl -u $user:$password --ssl-reqd --mail-from $from --mail-rcpt $to --url smtps://smtp.gmail.com:465 -T $file_compose"
            echo "$cmd"
            #xsel "$cmd"
            eval "$cmd" 
            #>/dev/null
        else
            notify-send 'skip sending'
        fi
    else
        reason_of_death 'no such file' "$file"
    fi
}
check(){
    print_func
    information
    check_depend_package
    check_depend_process
    check_depend_config
}
steps(){
    print_func
    check

    run
}
steps

