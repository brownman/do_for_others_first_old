#!/bin/bash


step1(){
local     file=$dir_self/RIDDLES/question.txt
local str=$( gxmessage -title 'add 1 question' -entry -file $file )
echo "$str" >> $file
}

steps(){
    step1
}


steps
