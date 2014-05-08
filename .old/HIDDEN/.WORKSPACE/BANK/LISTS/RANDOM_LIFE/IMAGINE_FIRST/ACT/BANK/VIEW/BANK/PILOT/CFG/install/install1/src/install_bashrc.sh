#!/bin/bash
#help01: \n install bashrc additions \n use environment var: dir_project to load local file:  bashrc.fun
#
path="$dir_project"
file_target=/tmp/11
touch $file_target
shadow1(){
    local str=`cat $file_target | grep dir_project`
    echo "$str"
}
step1(){
    local result=`shadow1`
    if [ "$result" = '' ];then
               
        echo "Installing.."
###
        echo "export dir_project=$path" >> $file_target
        echo "source $path/bashrc.fun" >> $file_target
###
        echo "File: $file_target"
        cat $file_target
        else
         print_about_self
    fi

}
steps(){
    step1
}
steps
