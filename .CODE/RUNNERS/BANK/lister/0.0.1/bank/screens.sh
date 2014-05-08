#!/bin/bash

dir=$dir_root/WIKI

pushd `$dir`>/dev/null
file_list=list.txt
step1(){
    #info: only the  first step
    print_func
ls -1 > list.txt
cat list.txt
}
step2(){
    print_func
while read file;do
#    echo "$line"
clear

cat $file
sleep 3
#    ls -l $line
done < $file_list
}


steps(){
    print_func
step1
step2
}

steps
popd
