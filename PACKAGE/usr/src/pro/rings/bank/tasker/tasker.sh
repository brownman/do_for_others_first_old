#!/bin/bash -e
echo 'tasker.sh' 
set -o nounset
#export SOUND=true
pushd `dirname $0`
dir_this=`pwd`
source $dir_root/setup.cfg

echo "dir_root $dir_root"
ls -l $dir_root
ROOM=2
file_list=$dir_this/rooms/room${ROOM}.txt 
args=()


ensure(){
    echo 'ensure()'

    echo "room: $ROOM : $file_list"
    echo
    cat $file_list
    echo
    echo
    echo 'delay: 5 seconds'
    sleep 5

}





parse(){
    echo 'parse()'
    echo -e "got[$#]::$@"
    echo
    if [ $# -gt 0 ];then
        args=( "$@" )
        echo "var args: ${args[@]}"
    fi
}

use(){
    echo 'use()'
    if [ -f "$act_sh" ];then
        
        cmd="$act_sh ${args[@]}"
        eval "$cmd"
    else
        echo 'no such script' "$act_sh"
    fi

}
single(){
    echo 'single()'
    while read line;do
        if [ "$line" != '' ];then
            echo "line: $line"
            parse $line           
            use
        else
            echo 'empty line'
            return
        fi
    done < $file_list
}
loop(){

    clear
    echo 'loop()'

    let 'counter=1'
    while [ 1 ];do


        touch ~/Desktop/round${counter}.txt
        str_remind="round $counter"

        xcowsay "$str_remind"
        flite -t "$str_remind"
        single

        let 'counter+=1'
    done
}
ensure
loop

popd
