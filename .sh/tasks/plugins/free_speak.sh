#!/bin/bash
#set -e
# about file:
# desc: talk to yourself and translate it


notify_send "free-speak" "$0"

#${1:-'essay_generator|story_a_day|funny'}
subject="$1"
delay=5
file_locker=/tmp/free_speak

export STRING_TO_BUTTONS=false


memory_game(){
    #file_name=${1:-'essay'}
    notify_send 'memory game'
    local file="$1"
 

  
    local result=0
    local counter=0 


local  str=$(cat $file | head -1)

    while :;do
        let counter+=1
        trace "loop $counter"
        #str=$(random_grammer) 
        #str=''
        str=$( gxmessage   $GXMESSAGE0 -entrytext "$str"  -title "$subject" -file "$file")
        #eval 'helper0 "$str" "$file"' 
        helper0 "$str" "$file"
        #echo01 "$str"
    done
}

run(){

local subject1=${subject:-'essay'}
local file=$DATA_DIR/txt/$subject1.txt 
touch $file
memory_game $file 
}

unlocker
#run
