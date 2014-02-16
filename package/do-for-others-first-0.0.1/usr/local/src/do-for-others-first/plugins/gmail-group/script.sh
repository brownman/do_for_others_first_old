#!/bin/bash -e


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
run
