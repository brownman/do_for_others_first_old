#!/bin/bash

question="$@"

dir=$dir_question/fu-master
script=fu
flag='-a'


search(){
local question="$@"
$dir/$script $flag "$question"
}
if [ ! "$question" ];then
echo 'Enter  your query'
read question
fi
search "$question"
