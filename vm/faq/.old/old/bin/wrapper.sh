#!/bin/bash
#whereis $1

if [ "$1" ];then
    script=$1
    if [ "$2" ];then
        shift
        args=( "$@" )
    fi
else
    echo 'supply a script to wrap'
    exit
fi



cmd="$script   ${args[@]}" 
echo "cmd: $cmd"

echo -n '' > logger
$(eval "$cmd") 2> logger
if [ ! -s logger ];then
    echo good
else
    echo bad

    str1=`cat logger | cut -d':' -f1`
    str2=`cat logger | cut -d':' -f2 | sed 's/line /+/g'`
    str3=`cat logger | cut -d':' -f3`
    str4=`cat logger | cut -d':' -f4`


    echo notify-send "$str4" "$str3" 
    notify-send "$str4" "$str3" 

    echo "vi $str2 $str1" | xsel --clipboard
    echo 'your clipboard has been updated!'
fi
