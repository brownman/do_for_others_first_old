#!/bin/bash


default(){


     msg=$( gxmessage -entry -sticky -ontop -timeout 3000 -title "user: $user password:$password" "My Message:" )
    if [ "$msg" != '' ];then
        echo "$msg" > $file_compose

        cmd="curl -u $user:$password --ssl-reqd --mail-from advance.linux1@gmail.com --mail-rcpt advance.linux1@gmail.com --url smtps://smtp.gmail.com:465 -T $file_compose"
        echo "$cmd"
        eval "$cmd" #>/dev/null
    fi


}



cmd=${1:-default}
eval "$cmd"
