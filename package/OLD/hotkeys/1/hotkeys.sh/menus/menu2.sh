#!/bin/bash

is_working=$( pstree -a | grep gmail | grep notify )
file=/tmp/send.txt


if [ "$is_working" = '' ];then
    notify-send "please run:" 'gmail-notify'
else
    msg=$( gxmessage -entry -sticky -ontop -timeout 3000 -title 'send a message' 'My Message:' )
    if [ "$msg" != '' ];then
        echo "$msg" > $file

        cmd="curl -u $user:$password --ssl-reqd --mail-from advance.linux1@gmail.com --mail-rcpt advance.linux1@gmail.com --url smtps://smtp.gmail.com:465 -T $file"
        echo "$cmd"
        eval "$cmd"
    fi
fi

