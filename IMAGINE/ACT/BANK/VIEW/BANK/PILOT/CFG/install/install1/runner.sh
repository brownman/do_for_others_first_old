#!/bin/bash 
#path=`dirname $0`

# Load all files in support
#for file in `ls $dir_install/support | grep .sh$`; do

    source $dir_install/config.cfg
    source $dir_install/testing.cfg
#done

# Load all files in src
#list=`ls $dir_install/src | grep .sh$`
#arr=( $list )
#echo "${list}" > /tmp/list1
#cat /tmp/list1
list=`cat $dir_install/list.txt`

for file in $list; do
path_file=$dir_install/src/$file
    echo "$file"
    source $path_file

    # OMG this is a bash test runner!! <3 <3 <3
    # functions=`declare -F | cut -d ' ' -f 3 | grep ^test_`
    # This style allows us to run tests in order
#    file_txt=`echo $file | sed 's/sh/txt/g'`
   # cmd="$EDITOR $dir_install/idea/$file_txt"

    #echo "$cmd"
    
    functions=`grep -h test_ $path_file | cut -d '(' -f 1`
    for i in $functions; do
        sleep1 1
        #rm -rf tmp/*
        blueN "\t$i -\t"
        $i
        echo
        #green1 "  $i"
    done

done
