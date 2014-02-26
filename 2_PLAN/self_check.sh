#!/bin/bash
file_priorities=./priorities.txt
let 'counter=0'
answer=''
step1(){


while read line;do
    read answer 
    read answer
    echo "step: $counter"
    echo "$line"
let     'counter+=1'
done < $file_priorities
}
step2(){


old_IFS=$IFS      # save the field separator           
IFS=$'\n'     # new field separator, the end of line           
for line in $(cat $file_priorities)          
do          

       echo $line

    read answer
   done          
   IFS=$old_IFS     # restore default field separator 

}
step2
