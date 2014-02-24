#!/bin/bash
set -o nounset
pushd `dirname $0`
echo "just suspend me!"
delay=300
path=`dirname $0`
dir_root=../../

let 'counter=0'
#str_remind="great! WOW! $counter"


file_setup=$dir_root/setup.cfg
source $file_setup
script_name=suspend
file=$dir_root/acts/$script_name/$script_name.sh

while [ 1 ];do

str_remind="$counter whiteboards"
    flite -t "$str_remind" &
    let 'counter+=1'
    file1=$counter.wow
    touch ~/Desktop/$file1
    xcowsay "$str_remind"


    if [ -f "$file" ];then
        echo "file:$file"
        eval "$file"
    else
        echo 'no such file' "$file"
        exit
    fi


    cmd="sleep $delay"
    echo "$cmd"
    eval "$cmd"

done
popd
