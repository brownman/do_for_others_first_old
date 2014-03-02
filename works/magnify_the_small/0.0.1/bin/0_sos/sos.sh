#!/bin/bash
set -o nounset
pushd `dirname $0`
echo "just suspend me!"
delay=600
path=`dirname $0`

let 'counter=0'


    dir=$dir_workspace/sos
    if [  ! -d "$dir" ];then
        mkdir -p  $dir
    fi
file=$suspend_sh

while [ 1 ];do

str_remind="$counter whiteboards"
    flite -t "$str_remind" &
    let 'counter+=1'
    file1=$counter.wow

    touch $dir/$file1
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
