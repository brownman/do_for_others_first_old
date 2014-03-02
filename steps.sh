#!/bin/bash -e

file=list.txt



while read line;do
    echo "$line"
    sleep 5
done < $file
