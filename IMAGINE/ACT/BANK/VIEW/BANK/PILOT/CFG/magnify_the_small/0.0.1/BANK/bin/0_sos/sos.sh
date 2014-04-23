#!/bin/bash 
echo "[SOS]"
figlet --gay "[SOS]"
#readiness: 2 of 5
#about: sos.sh - run a loop with only 1 task: suspend
#type: looper
#tasks: suspend
#help:  execute tasks in a loop
#use:   set time period for: suspension/alive 
zbabun
touch /slkdjfklf
set -o nounset
pushd `dirname $0`
path=`dirname $0`

set_suspend(){
    echo 'please supply a suspension steps: 1 is the shortest'
    read answer
    let 'answer_int=answer*60'
    echo "timeout will be: $answer_int"
    export TIMEOUT_SUSPEND=$answer_int
}
set_alive(){
    echo 'please supply a alive steps: 1 is the shortest'
    read answer
    let 'answer_int=answer*60'
    echo "alive will be: $answer_int"
    export TIMEOUT_ALIVE=$answer_int
    delay=$TIMEOUT_ALIVE
}

setup(){
    let 'counter=0'
    dir=$dir_workspace/sos
    if [  ! -d "$dir" ];then
        mkdir -p  $dir
    fi
    file=$suspend_sh
}
wellcome(){
    str="just suspend me!"
    xcowsay "$str"
}
loop(){
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
}

steps(){
    setup
    set_alive
    set_suspend
    loop
}

steps
popd
