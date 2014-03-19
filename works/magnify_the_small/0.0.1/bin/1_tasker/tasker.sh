#!/bin/bash -e 
echo 'tasker.sh' 
update_logger "$0" "$@"
#export SOUND=true
#pushd `dirname $0`
dir_this=`pwd`
#source $dir_root/setup.cfg

#echo "dir_root $dir_root"
#ls -l $dir_root

echo 'loading room: '
#read answer

num=${1:-2}
#${answer:-2}
echo "$num"
sleep 2
file_list=$dir_workspace/lists/rooms/room${num}.txt
args=()

install(){
    echo 'install()' 
dir=$dir_workspace/rounds
if [ ! -d "$dir" ];then
    mkdir -p $dir
fi
}



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
    done < $file_list
}
loop(){

    clear
    echo 'loop()'

    let 'counter=1'
    while [ 1 ];do


        touch $dir/round${counter}.txt
        str_remind="round $counter"

        xcowsay "$str_remind"
        flite -t "$str_remind"
        single

        let 'counter+=1'
   done
}
install
ensure
loop

#popd
