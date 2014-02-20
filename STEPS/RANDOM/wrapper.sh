#!/bin/bash -e
source helper.cfg


while read line;do
    cmd="every $line"
    echo "$cmd"
    sleep1 2
    eval "$cmd"
done < list.txt 
