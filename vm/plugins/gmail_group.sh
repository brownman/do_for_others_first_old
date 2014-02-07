#!/bin/bash

is_working=$( pstree -a | grep gmail | grep notify )
file=/tmp/send.txt
user=advance.linux1
password=advance.linux1
default(){


if [ "$is_working" = '' ];then
    

    echo "please run:" 'gmail-notify'
    notify-send "please run:" 'gmail-notify'
else
    msg=$( gxmessage -entry -sticky -ontop -timeout 3000 -title "user: $user password:$password" "My Message:" )
    if [ "$msg" != '' ];then
        echo "$msg" > $file

        cmd="curl -u $user:$password --ssl-reqd --mail-from advance.linux1@gmail.com --mail-rcpt advance.linux1@gmail.com --url smtps://smtp.gmail.com:465 -T $file"
        echo "$cmd"
        eval "$cmd"
    fi
fi

}



cmd=${1:-default}
eval "$cmd"
