#!/bin/bash -e
pushd `dirname $0`

file=txt/steps.txt



edit_txt(){
    echo 'edit_txt()'
gvim $file
}

step1(){
    echo 'step1()'
source cfg/basics.cfg
source cfg/pid.cfg
source cfg/proxy.cfg
}



step2(){
    echo 'step2()'
trap edit_txt SIGINT 
while read line;do
    echo "$line"
    sleep  2
done < $file
}



steps(){
step1
step2
}
steps
popd
