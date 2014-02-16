#!/bin/bash 
print_script


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
run
