#!/bin/bash  
exo-open http://wiki.bash-hackers.org/ & 
print_script
set -o nounset
#echo 'tasker.sh' 
#update_logger "$0" "$@"
#export SOUND=true
#pushd `dirname $0`
#dir_this=`pwd`
#source $dir_root/setup.cfg

#echo "dir_root $dir_root"
#ls -l $dir_root

echo 'loading room: '
#read answer

room_num=${1:-2}
#${answer:-2}
#echo "$num"
sleep 2
file_list_room="$dir_workspace/lists/rooms/room2.txt"
args=()

install(){
    print_func
    echo 'install()' 
local dir="$dir_workspace/rounds"
if [ ! -d "$dir" ];then
    proxy "mkdir -p $dir"
fi
}



ensure(){
    print_func
    echo 'ensure()'
if [ -f "$file_list_room" ];then
    echo "file list: $file_list_room"
    sleep 3

    echo "room: ROOM : $file_list_room"
    echo
    cat $file_list_room
    echo
    echo

else
    reason_of_death "no such file" "$file_list_room"
fi

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
    print_func
    echo 'use()'
    if [ -f "$single_sh" ];then

        cmd="$single_sh ${args[@]}"
        echo "$cmd"
        eval "$cmd"
    else
        echo 'no such script' "$single_sh"
        exiting
    fi

}
single(){
    print_func
    echo 'single()'
    while read line;do
        if [ "$line" != '' ];then
            echo "line: $line"
            parse $line           
            use
        else
            reason_of_death 'empty line'
            return
        fi
    done < $file_list_room
}
loop(){
print_func


local dir=$dir_workspace/rounds
proxy     clear
    echo 'loop()'

    local counter=1
    while [ 1 ];do


#        touch $dir/round${counter}.txt
     local   str_remind="round $counter"

proxy        xcowsay "$str_remind"
     proxy    flite -t "$str_remind"
     proxy   single

        let 'counter+=1'
   done
}
steps(){
##install
ensure
loop
}
steps
#popd
set +o nounset
