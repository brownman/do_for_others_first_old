#!/bin/bash
lang=ru
export SOUND=true
file_priorities=list.txt
let 'counter=0'
answer=''
:<<ABC




step1(){


    while read line;do

        echo "step: $counter"
        echo "$line"

        cmd="$single_sh  translate ru \"$answer\""
        echo "$cmd"
        eval "$cmd"
        let     'counter+=1'
    done < $file_priorities
}

ABC
step2(){


    old_IFS=$IFS      # save the field separator           
    IFS=$'\n'     # new field separator, the end of line           
    for line in $(cat $file_priorities)          
    do          
        read answer
        if [ "$answer" = '+' ];then
            export SOUND=true
        elif [ "$answer" = '-' ];then
            export SOUND=false
        else
        $single_sh translation "$lang" "$answer"
        fi
    done          
    IFS=$old_IFS     # restore default field separator 

}
step2
