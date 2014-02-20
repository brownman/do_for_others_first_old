#!/bin/bash -e
#help: supply argument: record OR replay
option=$1

path=`dirname $0`
dir=$path/movies
if [ ! -d "$dir" ];then
    echo 'generating directory.. ./movie'
    mkdir -p "$dir" 
fi

if [ "$option" = '' ];then
    clear
    cat $0 | grep --color=auto -m1 help
    echo _
    echo _
    exit 0
fi
if [ "$option" = record ];then
    echo how do you want to call the new shell-recording ?
    read name
    if [ "$name" = '' ];then
        echo 'invalid name'
        exit 1
    else
        name=`echo $name | sed 's/ /_/g'`
    fi
    #    timestamp=`date | cut -d' ' -f3,4| sed 's/ /_/g'`


    #   file="$name_$timestamp"

    file="$name"

    #echo "$"
    echo "<do your work>; <CTRL-D>;"
    file_time=$dir/$file.time
    file_out=$dir/$file.out

    echo "file is: $dir/$file_time"
    script -t $file_time 2>$file_out;

else
    ls -1 $dir/*.time

    echo 'select a movie to play'
    read name
    file="$name"
    file_time=$dir/$file.time
    file_out=$dir/$file.out

    if [ -f "$file_time" ] && [ -f "$file_out" ];then

        clear
        echo 'are you ready to the comming of the great movie ?'
        echo 'wait 3 seconds, relax and sit back, while we process your new grant nominated video'

        sleep 1
        echo -n '(3)'
        sleep 1
        echo -n '(2)'
        sleep 1
        echo -n '(1)'
        clear
        cmd="scriptreplay $file_time $file_out"
        echo "$cmd"
        eval "$cmd"
        echo
        echo "-  The end."
        echo 'you should sent it to the oscar carnaval'
    else
echo "invalid filename: $file_time"
    fi
fi
