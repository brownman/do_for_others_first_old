#!/bin/bash -e
echo 'tasker.sh' 
#export SOUND=true
pushd `dirname $0`
dir_this=`pwd`
#source $dir_root/setup.cfg

echo "dir_root $dir_root"
ls -l $dir_root

echo 'which room to load ?'
#read answer
answer=1

num=${answer:-2}
file_list=$dir_workspace/lists/rooms_cli/room${num}.txt
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
    #echo 'parse()'
    #echo -e "got[$#]::$@"
    echo
    if [ $# -gt 0 ];then
        args=( "$@" )
     #   echo "var args: ${args[@]}"
    fi
}

use(){
  #  echo 'use()'
    if [ -f "$single_cli_sh" ];then

        cmd="$single_cli_sh ${args[@]}"
        eval "$cmd"
    else
        echo 'no such script' "$single_cli_sh"
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

popd