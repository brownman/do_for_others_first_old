#!/bin/bash -e

question="$@"

dir=$dir_vendor/fu-master
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
