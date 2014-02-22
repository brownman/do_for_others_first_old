#!/bin/bash
set -o nounset 
NAME=ofer

#change between false and true - to sound / unsound
SOUND=true
sound=$SOUND
dir_script=`dirname $0`
file=$dir_script/list.txt
cmd=${1:-'run'}


speak(){
local line="$1"
if [ "$line" ];then


notify-send "$line" & 
if [ "$sound" = true ];then

echo "$line" | flite -voice slt &
sleep 1
echo "$line" | flite -voice kal &
sleep 1
echo "$line" | flite -voice awb &
else
    echo "sound:" "$line"
fi

fi

}
run(){
    echo 'run()'
local line=$(random_line $file)
speak "$NAME"
speak "$line"
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


