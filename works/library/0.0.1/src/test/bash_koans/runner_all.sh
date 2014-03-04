#!/bin/bash  -e
pushd `dirname $0` >/dev/null
if [ "$LIBRARY_LOADED" = true ];then
    echo '[ok] library was loaded'
else
    echo '[error] library was not loaded!'
    exit 1
fi
#print_script
#path=`dirname $0`
#path=.
set -o nounset
path=`pwd`
echo "pwd: $path"
dir_target=$dir_library/src/rc/cfg/public
file_list=$dir_workspace/lists/tested_files.txt
# Load all files in support
#for file in `ls $dir_install/support | grep .sh$`; do


#source $dir_koans/config.cfg
source $dir_library/src/test/bash_koans/testing.cfg
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
reason_of_death(){
    echo reason of death:
    echo "$@"
}
run(){
    source $file_test
    functions=`grep -h test_ $file_test | cut -d '(' -f 1`
    for i in $functions; do
        #rm -rf tmp/*
        print_color 34 "\t\t\t\t\t $i !!!"
        eval "$i"
        echo
        #green1 "  $i"
    done
    #done

    return $SUCCESS
} 
single(){


    if [  $# -eq 0 ];then
        reason_of_death 'no arguments - no file to test'
    else
        file_test=$1
        file_short=`basename $file_test`
        echo "Test this File: $file_short"
        run
    fi

}


steps(){
    echo 'steps()'
    echo 'tesing: inline tests from: ' "$dir_target" 


   find $dir_target -type f |  xargs grep --exclude-dir=.old test_ | cut -d':' -f1  > $file_list


    while read line;do
single       "$line"
    done <  $file_list



}
steps
popd
