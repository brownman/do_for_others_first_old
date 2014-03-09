#!/bin/bash  -e

set -o nounset

pushd `dirname $0` >/dev/null
    path=`pwd`
    echo "pwd: $path"
    dir_target=${1:-''}

step0(){
    if [ ! -d "$dir_target" ];then
        reason_of_death 'invalid dir' "$dir_target"
    else
        echo "dir_target: $dir_target"
    fi
    file_list=$dir_workspace/lists/tested_files.txt
    source $path/testing.cfg
}
# Load all files in support
#for file in `ls $dir_install/support | grep .sh$`; do


#source $dir_koans/config.cfg

#source $dir_install/testing.cfg
#done

# Load all files in src
#list=`ls $dir_install/src | grep .sh$`
#arr=( $list )
#echo "${list}" > /tmp/list1
#cat /tmp/list1
#list=`cat $dir_install/list.txt`

#for file in $list; do
#path_file=$dir_install/src/$file
#    echo "$file"
#    source $path_file

# OMG this is a bash test runner!! <3 <3 <3
# functions=`declare -F | cut -d ' ' -f 3 | grep ^test_`
# This style allows us to run tests in order
#    file_txt=`echo $file | sed 's/sh/txt/g'`
# cmd="$EDITOR $dir_install/idea/$file_txt"

#echo "$cmd"
run(){
    source $file_test
    functions=`grep -h test_ $file_test | cut -d '(' -f 1`
    for i in $functions; do
        #rm -rf tmp/*
        green "$i"
        eval "$i"
        #echo
        #green1 "  $i"
    done
    #done

    #    return $SUCCESS
} 
single(){


    if [  $# -eq 0 ];then
        reason_of_death 'no arguments - no file to test'
    else
        file_test=$1
        file_short=`basename $file_test`
        #echo "Test this File: $file_short"
        run
    fi

}
step01(){
    find $dir_target -type f |  xargs grep --exclude-dir=.old test_ | cut -d':' -f1  > $file_list
}

step1(){
    #echo 'steps()'
    #echo 'tesing: dir: ' "$dir_target" 
    while read line;do
        single       "$line"
    done <  $file_list
    #cmd="wc --lines $file_list | cut -d' ' -f1"
    #echo "$cmd"
    #num=`eval "$cmd"`

    #   echo "[ NUMBER ] : $num"


}
steps(){
step0
step01
step1
}
steps
popd >/dev/null
