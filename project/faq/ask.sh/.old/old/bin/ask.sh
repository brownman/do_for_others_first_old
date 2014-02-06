#!/bin/bash
#ask a question, add tags, make it publicly available, then GET HELP!
print_status 'if you feel that HELP will come - that is FREEDOM!'
print_good 'send your bread over the water'
#echo 'shoot' | flite
GUI=false
args=( "$@" )
if [  ! -d $dir_workspace  ];then
mkdir -p $dir_workspace
fi

file=$dir_workspace/questions.txt

if [  "$args"  ];then
    question="${args[@]}"
else
    if [ "$GUI" = false ];then
        read question
    else
        question=$( gxmessage -title question -file questions.txt -entry )
    fi
fi
if [  "$question" ];then
print_good 'SUCCESS'
echo $question >> $file
fi



print_good $file
cat -s $file


