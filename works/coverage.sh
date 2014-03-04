#!/bin/bash 
echo hi
#set -o nounset
let 'readiness=0'
path=`pwd`

library_loaded=${LIBRARY_LOADED:-false}
echo library loaded: $library_loaded
if [ "$library_loaded" = false ];then
    echo exiting
    exit 1
else
    echo '[OK] library loaded'
fi

#help: present the readiness of the projects
#details: does it have a readme(version,todo,changelog). does it have test.sh ?. does is have a presentation for its current version ?
#describe: a presentation
#todo:   1.create a short presentation automaticly
#todo:   2.add tests
#todo:   set a readiness score for each sub-project:
step0(){
echo step0
echo show the subdirectories
ls $path
}


step1(){
#who has a readme ?
echo  step1
echo  check if folder has a readme
directories=`ls -d`
for directory in $directories;do
    file=` ls $directory/README.md`
    if [ -f $file ];then

        echo check_for_version
        level0=`cat $file | version -A 4`


        echo check_for_todos
        level1=`cat $file | todo -A 4`

        echo check_for_changelog
        level2=cat $file | changelog -A 4
    fi
done
echo
}

step2(){
#who  has tests ?
echo step2
echo check if folder has test.sh
}
step3(){
echo step3
echo check for a presentation for the current version
}

step4(){
echo step4
echo caclculate the readiness level of the project!
}

steps(){
echo 'what is inside ?'
step0
step1
step2
step3
step4
}

help(){
echo 'help()'
self_help
#cat $0 | grep help -m1
#cat $0 | grep todo -v grep
#cat $0 | grep describe -v grep
}
echo 'start:'
cmd=${1:-help}
$cmd

