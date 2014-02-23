#!/bin/bash -e
#export SOUND=true
dir_parent=`pwd`
ROOM=2
file_list=$dir_parent/rooms/room${ROOM}.txt 


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
script_name=$1
echo "var script_name: $script_name"
shift
args=( "$@" )
echo "var args: ${args[@]}"

}
use(){
    echo 'use()'
            script=$dir_parent/acts/$script_name/$script_name.sh
            if [ -f "$script" ];then
                cmd="$script ${args[@]}"
                eval "$cmd"
            else
                echo 'no such script' "$script"
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
    touch ~/Desktop/round${counter}.txt
    let 'counter=1'
    while [ 1 ];do
        let 'counter+=1'
        single
    done
}
ensure
loop

