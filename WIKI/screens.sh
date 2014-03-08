#!/bin/bash
pushd `dirname $0`>/dev/null
step1(){
    #info: only the  first step
    print_func
ls -1 > list.txt
cat list.txt
}
step2(){
    print_func
while read line;do
    echo "$line"
done < $file_list
}


steps(){
    print_func
step1
step2
}

steps
popd
