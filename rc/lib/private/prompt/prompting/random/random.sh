#!/bin/bash -e
echo "LOADED:"

clear
#set -o  errtrace
dir=`pwd`
echo "dir: $dir"
#source $dir/helper.cfg
file_list=$dir/list.txt 

every2(){

    echo 'every2()' 
    arr=( "$@" )
    if [ "${#arr[@]}" -eq 3 ];then
        num="${arr[0]}"
        msg="${arr[1]}"
        cmd="${arr[2]}"
        echo -e "every2:\n $num \n $msg \n $cmd"
        res=$(random2 $num)
        res1=$?
        echo "got from random2: "
        echo ": $res"
        echo ": $res1"
        exiting
        echo "dice: 0 < $res < $num) "
        if [ "$res" -ne 0 ];then
            echo "executing:"
            echo "cmd: $cmd"
            eval "$cmd"
        else
            echo -n "Skipping:"
            echo "$msg"
        fi
    else
        echo    reason_of_death "need 3 arruments - got $#" "arr: $@"
    fi
}

random2(){
    echo 'random2'
    if [ $# -eq 1 ];then
        num=$1
        let "result = $RANDOM % $num"
    else
        echo reason_of_death 'no arruments - no integer'
        let 'result=-1'
    fi
    echo "$result"
    return $result
}
step2(){
echo "step2"
echo "string to arr"
local line="$@"
IFS='|' read -a arr <<< "$line"
echo "[${#arr[@]}]:${arr[@]}" 
every2 "${arg[@]}"
}

step1(){
    echo 'load: list.txt - loop over each line and send it to step2()'
    echo print_func
    while read line;do


        #        echo "$line0"
        #line0=`echo "$line0"`

        if [ "$line" != '' ];then
            echo "line: $line"

            #       line=( $line0 )
            #      echo "${#line[@]}"
            # echo 'another line:' "$line"
            #    echo "every2 $line"
            #    every2 $line
            step2 "$line"
            #"${arr[@]}"
        else
            echo  "encounterd empty line on $file_list"
            echo exit
            exit
        fi
    done < $file_list

}
steps(){
    step1
}
steps
