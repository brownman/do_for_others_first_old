#!/bin/bash
file_priorities=./priorities.txt
let 'counter=0'
answer=''

while read line;do


    read answer 
    read answer
#    echo "step: $counter"



#    echo "$line"
let     'counter+=1'
done < $file_priorities
