#!/bin/bash
dir=`pwd`
dir_txt=$dir/plans
file_question=$dir/steps.txt
file_answer=$dir_txt/planning.txt
echo "$time1"



run(){


let 'cnt=0'
while read $line
do
        echo "$cnt: $line"
        read answer
        echo  "$answer" >> $file_answer
    cnt=$((cnt+1))
done < $file_question

}
run
