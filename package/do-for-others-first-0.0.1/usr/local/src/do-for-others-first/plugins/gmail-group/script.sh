#!/bin/bash -e
#author:         ofer shaham
#plugin:    gmail-group
#package:        do-for-others-first
#version:   0.0.1
#date:      15.2.2014
#depend:    gxmessage gmail-notify libnotify-bin
#help:      utilize shared gmail to act like the mobile application: whatsup 
#arguments: update your .bashrc with USER=gmail_nickname PASSWORD=gmail_passwort
#check:     ps -ef | grep gmail-notify | grep -v grep

#31 - red
#32 - green
#33 - yellow

################################### env ################################\
user=${GMAIL_USER:-''} #env
password=${GMAIL_PASSWORD:-''} #env
from=$user@gmail.com
to=$user@gmail.com
FAILURE=false
SUCCESS=true
file_msg=/tmp/file_msg.txt
########################################################################/



################################### helpers ############################\
print_color_n()       { echo -en "\x1B[01;$1m[*]\x1B[0m $2 "; }
print_color()       { echo -e "\x1B[01;$1m[*]\x1B[0m $2 "; }
remove_trailing(){
    local res=$(echo "$1" | sed -e 's/^ *//g' -e 's/ *$//g')
    echo "$res"
}
########################################################################/

test(){


    ########################## Test Requirements: ##################################\   
    ################################################################################\
    print_func
    result=$SUCCESS
    ########################## install dependencies ######################\   
    list=`pull depend`
    for item in $list;do
        cmd="dpkg -L $item"
        eval "$cmd" >/dev/null 2>&1 || { echo >&2 "sudo apt-get install $item" ;result=$FAILURE; }
    done

    ########################### test if gmail-notify is running ##########\

    cmd=`pull check`
    str=`eval "$cmd"`
    [ -z "$str" ] && { echo >&2 "please run gmail-notify" ;result=$FAILURE; }


    ########################### test if the user update the default configurations ##########\

    [ -z "$user" ] && { echo >&2 "please update your gmail settings which located in this file" ;result=$FAILURE; }
    
    echo $result
}

pull(){
    subject="$1"
    str=`cat $0 | grep "$subject:" | cut -d':' -f2`
    remove_trailing "$str"

}
expose(){
    subject="$1"
    print_color_n 33 "$subject:\t\t"
    pull "$subject"
}

print_func(){
    echo -e "--> ${FUNCNAME[1]}():" >&2
}

info(){
    print_func

    expose plugin
    expose help
}

run(){
    print_func
    echo -e "user:$user\npassword:$password\nfrom:$from\nto:$to" > $file_msg
    msg=$( gxmessage -entry -sticky -ontop -timeout 3000  -file $file_msg -title "Compose:" )
    if [ "$msg" != '' ];then
        echo -e "$LOGNAME:\t $msg" > $file_compose
        cmd="curl -u $user:$password --ssl-reqd --mail-from $from --mail-rcpt $to --url smtps://smtp.gmail.com:465 -T $file_compose"
        echo "$cmd"
        #xsel "$cmd"
        eval "$cmd" 
        #>/dev/null
    else
        notify-send 'skip sending'
    fi
}

steps(){
    clear
    print_func
    info
    local res=$( eval test )

    if [ "$res" = $SUCCESS ];then
        print_color 32 'run!'
        run
    else
        print_color 31 'follow the Instructions -> then try again!'
    fi
}


steps

