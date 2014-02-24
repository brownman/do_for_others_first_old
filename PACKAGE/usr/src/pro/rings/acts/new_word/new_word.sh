#!/bin/bash

#change between false and true - to mute / unmute
export SOUND=true
dir_script=`dirname $0`
file=$dir_script/list.txt
cmd=${1:-'run'}
lang=${LANG_DEFAULT:-ru}

run(){
    echo 'run()'
local line=$(random_line $file)
if [ "$line" ];then
notify-send "$line" & 

cmd="$translate_sh $lang $line"
echo "$cmd"
eval "$cmd"
else
    echo "mute:" "$line"
fi

}


random_line(){
#    echo 'random_line()'
local file="$1"
if [ -f "$file" ];then
local line=$( shuf -n 1 $file ) 
echo "$line"
else 
    echo 'no such file' "$file"
fi
}
run


