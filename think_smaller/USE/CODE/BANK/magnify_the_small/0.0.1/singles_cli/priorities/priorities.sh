#!/bin/bash -e
path=`dirname $0`

file=$path/list.txt



while read line;do
    echo "$line"
    sleep 5
done < $file
